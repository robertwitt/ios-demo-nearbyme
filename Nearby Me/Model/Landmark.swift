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
    
    let data: [String: Any]
    
    var shortDescription: String? {
        get {
            if let terms = data[Landmark.keyTerms] as? [String: Any], let description = terms[Landmark.keyDescription] as? String {
                return description
            } else {
                return nil
            }
        }
    }
    
    var distance: CLLocationDistance? {
        get {
            return data[Landmark.keyDistance] as? CLLocationDistance
        }
    }
    
    var location: CLLocation? {
        get {
            if let coordinates = data[Landmark.keyCoordinates] as? [String : Any], let latitude = coordinates[Landmark.keyLatitude], let longitude = coordinates[Landmark.keyLongitude] {
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
    
    var thumbnailUrl: URL? {
        get {
            if let thumbnail = data[Landmark.keyThumbnail] as? [String: Any], let source = thumbnail[Landmark.keySource] as? String {
                return URL(string: source)
            } else {
                return nil
            }
        }
    }
    
    var url: URL? {
        get {
            if let url = data[Landmark.keyUrl] as? String {
                return URL(string: url)
            } else {
                return nil
            }
        }
    }
    
    init(data: [String: Any]) {
        self.data = data
    }
    
}
