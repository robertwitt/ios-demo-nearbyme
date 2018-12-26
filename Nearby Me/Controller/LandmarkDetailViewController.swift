//
//  LandmarkDetailViewController.swift
//  Nearby Me
//
//  Created by Robert Witt on 26.12.18.
//  Copyright © 2018 Robert Witt. All rights reserved.
//

import UIKit
import WebKit

class LandmarkDetailViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: Properties & Outlets
    var landmark: Landmark? {
        didSet {
            self.title = landmark?.title
        }
    }

    @IBOutlet weak var webView: WKWebView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoadingLandmarkDetail()
    }
    
    //MARK: Actions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    //MARK: Manage Landmark Detail
    
    func startLoadingLandmarkDetail() {
        if let landmarkUrl = landmark?.url {
            networkActivityEnabled = true
            webView.navigationDelegate = self
            webView.load(URLRequest(url: landmarkUrl))
        }
    }
    
}

//MARK: Web Navigation Delegate

extension LandmarkDetailViewController {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        networkActivityEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        networkActivityEnabled = false
        showAlertWithError(error)
    }
    
}
