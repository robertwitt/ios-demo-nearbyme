//
//  LandmarkFinder.swift
//  Nearby Me
//
//  Created by Robert Witt on 25.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LandmarkFinder {
    
    private let serviceUrl = "https://en.wikipedia.org/w/api.php?action=query&formatversion=2&prop=info%7Ccoordinates%7Cpageimages%7Cpageterms&inprop=url&colimit=50&piprop=thumbnail&pithumbsize=144&pilimit=50&wbptterms=description&generator=geosearch&ggscoord=37.33233141%7C-122.03121860&ggsradius=1000&ggslimit=10"
    
    private var mockLandmarks: [Landmark] {
        get {
            let landmarks = [Landmark(data: [Landmark.keyPageId: 46318869,
                                             Landmark.keyTitle: "International Federation of Inventors' Associations",
                                             Landmark.keyUrl: "https://en.wikipedia.org/wiki/International_Federation_of_Inventors%27_Associations",
                                             Landmark.keyThumbnail: [Landmark.keySource: "https://upload.wikimedia.org/wikipedia/en/thumb/2/24/Ifia_logo.jpeg/144px-Ifia_logo.jpeg"],
                                             Landmark.keyCoordinates: [Landmark.keyLatitude: 37.33182, Landmark.keyLongitude: -122.03118]]),
                             Landmark(data: [Landmark.keyPageId: 6400662,
                                             Landmark.keyTitle: "Saint Joseph of Cupertino Parish",
                                             Landmark.keyUrl: "https://en.wikipedia.org/wiki/Saint_Joseph_of_Cupertino_Parish",
                                             Landmark.keyThumbnail: [Landmark.keySource: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/St_joseph_of_cupertino_parish_front.JPG/144px-St_joseph_of_cupertino_parish_front.JPG"],
                                             Landmark.keyCoordinates: [Landmark.keyLatitude: 37.324204, Landmark.keyLongitude: -122.032001]])]
            return landmarks
        }
    }
    
    func search(aroundLocation location: CLLocation, inRadius radius: CLLocationDistance, maxHits: Int, completion: (_: [Landmark], _: Error?) -> Void) {
        //TODO: Invoke service URL
        
        let landmarks = self.mockLandmarks
        completion(landmarks, nil)
    }
    
    func loadImage(atUrl url: URL, completion: (_: UIImage?, _: Error?) -> Void) {
        // TODO: Invoke URL and return image in closure
    }
    
}
