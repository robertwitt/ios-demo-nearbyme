//
//  LandmarkViewController.swift
//  Nearby Me
//
//  Created by Robert Witt on 25.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LandmarkViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Properties & Outlets
    
    private let locationManager = CLLocationManager()
    private let landmarkFinder = LandmarkFinder()
    
    private var networkActivityEnabled: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set(networkActivityEnabled) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = networkActivityEnabled
        }
    }
    
    private var mapRadius: CLLocationDistance {
        get {
            let centerLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            let topCenterCoordinate = mapView.convert(CGPoint(x: mapView.frame.size.width / 2.0, y: 0), toCoordinateFrom: mapView)
            let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
            return centerLocation.distance(from: topCenterLocation)
        }
    }

    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerMapAnnotationViews()
        enableLocationService()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "LandmarkDetail":
            let annotationView = sender as! MKAnnotationView
            let landmarkDetailViewController = (segue.destination as! UINavigationController).topViewController as! LandmarkDetailViewController
            landmarkDetailViewController.landmark = annotationView.annotation as? Landmark
            break
        default:
            break
        }
    }
    
    //MARK: Actions
    
    @IBAction func locateTapped(_ sender: UIBarButtonItem) {
        startLocatingUser()
    }
    
    @IBAction func refreshMapTapped(_ sender: UIBarButtonItem) {
        startFindingLandmarksInLocation(CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude))
    }
    
    //MARK: Manage Locations
    
    private func enableLocationService() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            startLocatingUser()
            break
        default:
            return
        }
    }
    
    private func startLocatingUser() {
        if CLLocationManager.locationServicesEnabled() {
            networkActivityEnabled = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 0
            locationManager.startUpdatingLocation()
        }
    }
    
    private func showAlertWithError(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    //MARK: Manage Landmarks
    
    private func registerMapAnnotationViews() {
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Landmark")
    }
    
    private func startFindingLandmarksInLocation(_ location: CLLocation) {
        networkActivityEnabled = true
        let radius = self.mapRadius
        let maxHits = 50
        landmarkFinder.search(aroundLocation: location, inRadius: radius, maxHits: maxHits) { (landmarks, error) in
            if let error = error {
                self.showAlertWithError(error)
            } else {
                self.addLandmarksToMap(landmarks)
            }
            self.networkActivityEnabled = false
        }
    }
    
    private func addLandmarksToMap(_ landmarks: [Landmark]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(landmarks)
    }
    
}

//MARK: - Map View Delegate

extension LandmarkViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Landmark", for: annotation)
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !view.annotation!.isKind(of: MKUserLocation.self) else {
            return
        }
        networkActivityEnabled = true
        let landmark = view.annotation as! Landmark
        if let thumbnailUrl = landmark.thumbnailUrl {
            landmarkFinder.loadImage(atUrl: thumbnailUrl) { (image, error) in
                if let error = error {
                    self.showAlertWithError(error)
                } else {
                    view.leftCalloutAccessoryView = UIImageView(image: image)
                }
                self.networkActivityEnabled = false
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "LandmarkDetail", sender: view)
    }
    
}

//MARK: - Location Manager Delegate

extension LandmarkViewController {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocatingUser()
            break
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
            networkActivityEnabled = false
            startFindingLandmarksInLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        networkActivityEnabled = false
        showAlertWithError(error)
    }
    
}
