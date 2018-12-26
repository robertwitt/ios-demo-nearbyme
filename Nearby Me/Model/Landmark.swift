//
//  Landmark.swift
//  Nearby Me
//
//  Created by Robert Witt on 25.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import CoreLocation

class Landmark: NSObject {
    
    static let keyCoordinates = "coordinates"
    static let keyDistance = "dist"
    static let keyHeight = "height"
    static let keyLatitude = "lat"
    static let keyLongitude = "lon"
    static let keyPageId = "pageid"
    static let keySource = "source"
    static let keyThumbnail = "thumbnail"
    static let keyTitle = "title"
    static let keyWidth = "width"
    
    let data: [String: Any]
    
    var distance: CLLocationDistance? {
        get {
            return data[Landmark.keyDistance] as? CLLocationDistance
        }
    }
    
    var location: CLLocation? {
        get {
            if let latitude = data[Landmark.keyLatitude], let longitude = data[Landmark.keyLongitude] {
                return CLLocation(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
            } else {
                return nil
            }
        }
    }
    
    var pageId: String? {
        get {
            return data[Landmark.keyPageId] as? String
        }
    }
    
    var title: String? {
        get {
            return data[Landmark.keyTitle] as? String
        }
    }
    
    init(data: [String: Any]) {
        self.data = data
    }
    
}
