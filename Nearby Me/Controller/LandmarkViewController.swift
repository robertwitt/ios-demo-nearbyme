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
    
    //MARK: - Properties & Outlets
    
    private let locationManager = CLLocationManager()
    
    private var networkActivityEnabled: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set(networkActivityEnabled) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = networkActivityEnabled
        }
    }

    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationService()
    }
    
    //MARK: - Actions
    
    @IBAction func locateTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func refreshMapTapped(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Manage Locations
    
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        networkActivityEnabled = false
        showAlertWithError(error)
    }
    
}
