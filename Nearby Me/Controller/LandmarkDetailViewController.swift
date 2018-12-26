//
//  LandmarkDetailViewController.swift
//  Nearby Me
//
//  Created by Robert Witt on 26.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import UIKit
import WebKit

class LandmarkDetailViewController: UIViewController {
    
    //MARK: Properties & Outlets
    var landmark: Landmark?

    @IBOutlet weak var webView: WKWebView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
