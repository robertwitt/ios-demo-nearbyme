//
//  Landmark.swift
//  Nearby Me
//
//  Created by Robert Witt on 25.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class Landmark: NSObject {
    
    static let keyCoordinates = "coordinates"
    static let keyDescription = "description"
    static let keyDistance = "dist"
    static let keyHeight = "height"
    static let keyLatitude = "lat"
    static let keyLongitude = "lon"
    static let keyPageId = "pageid"
    static let keySource = "source"
    static let keyTerms = "terms"
    static let keyThumbnail = "thumbnail"
    static let keyTitle = "title"
    static let keyUrl = "fullurl"
    static let keyWidth = "width"
    
    let data: JSON
    
    var shortDescription: String? {
        get {
            return data[Landmark.keyTerms][Landmark.keyDescription].string
        }
    }
    
    var distance: CLLocationDistance? {
        get {
            return data[Landmark.keyDistance].double
        }
    }
    
    var location: CLLocation? {
        get {
            if let latitude = data[Landmark.keyCoordinates][Landmark.keyLatitude].double, let longitude = data[Landmark.keyCoordinates][Landmark.keyLongitude].double {
                return CLLocation(latitude: latitude, longitude: longitude)
            } else {
                return nil
            }
        }
    }
    
    var pageId: String? {
        get {
            return data[Landmark.keyPageId].string
        }
    }
    
    var title: String? {
        get {
            return data[Landmark.keyTitle].string
        }
    }
    
    var thumbnailUrl: URL? {
        get {
            if let thumbnailSource = data[Landmark.keyThumbnail][Landmark.keySource].string {
                return URL(string: thumbnailSource)
            } else {
                return nil
            }
        }
    }
    
    var url: URL? {
        get {
            if let url = data[Landmark.keyUrl].string {
                return URL(string: url)
            } else {
                return nil
            }
        }
    }
    
    init(data: JSON) {
        self.data = data
    }
    
}
