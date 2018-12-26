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
import Alamofire
import SwiftyJSON

class LandmarkFinder {
    
    static let endpoint = "https://en.wikipedia.org/w/api.php"
    
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
    
    func search(aroundLocation location: CLLocation, inRadius radius: CLLocationDistance, maxHits: Int, completion: @escaping (_: [Landmark], _: Error?) -> Void) {
//        let landmarks = self.mockLandmarks
//        completion(landmarks, nil)
        
        let parameters = ["action": "query",
                          "format": "json",
                          "formatversion": "2",
                          "prop": "info|coordinates|pageimages|pageterms",
                          "inprop": "url",
                          "colimit": "50",
                          "piprop": "thumbnail",
                          "pithumbsize": "72",
                          "pilimit": "50",
                          "wbptterms": "description",
                          "generator": "geosearch",
                          "ggscoord": "\(String(location.coordinate.latitude))|\(String(location.coordinate.longitude))",
                          "ggsradius": String(radius > 10000 ? 10000 : radius),
                          "ggslimit": String(maxHits)]
        
        Alamofire.request(LandmarkFinder.endpoint, method: .get, parameters: parameters).responseJSON { (response) in
            var landmarks = [Landmark]()
            if (response.result.isSuccess) {
                let result = JSON(response.result.value!)
                landmarks = self.parseLandmarks(fromQueryResult: result)
            }
            completion(landmarks, response.result.error)
        }
    }
    
    func loadImage(atUrl url: URL, completion: @escaping (_: UIImage?, _: Error?) -> Void) {
        Alamofire.request(url).responseData { (response) in
            var image: UIImage?
            if response.result.isSuccess {
                let imageData = response.result.value!
                image = UIImage(data: imageData)
            }
            completion(image, response.result.error)
        }
    }
    
    private func parseLandmarks(fromQueryResult result: JSON) -> [Landmark] {
        var landmarks = [Landmark]()
        let pages = result["query"]["pages"].arrayValue
        for page in pages {
            landmarks.append(Landmark(data: page))
        }
        return landmarks
    }
    
}
