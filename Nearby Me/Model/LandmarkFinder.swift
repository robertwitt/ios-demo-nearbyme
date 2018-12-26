//
//  LandmarkFinder.swift
//  Nearby Me
//
//  Created by Robert Witt on 25.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import CoreLocation

class LandmarkFinder {
    
    private var mockLandmarks: [Landmark] {
        get {
            let landmarks = [Landmark(data: [Landmark.keyPageId: 46318869,
                                             Landmark.keyTitle: "International Federation of Inventors' Associations",
                                             Landmark.keyLatitude: 37.33182,
                                             Landmark.keyLongitude: -122.03118,
                                             Landmark.keyDistance: 57]),
                             Landmark(data: [Landmark.keyPageId: 6400662,
                                             Landmark.keyTitle: "Saint Joseph of Cupertino Parish",
                                             Landmark.keyLatitude: 37.324204,
                                             Landmark.keyLongitude: -122.032001,
                                             Landmark.keyDistance: 906.4])]
            return landmarks
        }
    }
    
    func search(aroundLocation location: CLLocation, inRadius radius: CLLocationDistance, maxHits: Int, completion: (_ : [Landmark], _ : Error?) -> Void) {
        //TODO: Invoke service URL
        
        let landmarks = self.mockLandmarks
        completion(landmarks, nil)
    }
    
}
