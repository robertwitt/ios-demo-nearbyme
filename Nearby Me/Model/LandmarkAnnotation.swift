//
//  LandmarkAnnotation.swift
//  Nearby Me
//
//  Created by Robert Witt on 26.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import MapKit

extension Landmark: MKAnnotation {    
    
    var coordinate: CLLocationCoordinate2D {
        return location!.coordinate
    }

}
