//
//  ViewControllerExtension.swift
//  Nearby Me
//
//  Created by Robert Witt on 26.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var networkActivityEnabled: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set(networkActivityEnabled) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = networkActivityEnabled
        }
    }
    
}
