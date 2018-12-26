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
    
}
