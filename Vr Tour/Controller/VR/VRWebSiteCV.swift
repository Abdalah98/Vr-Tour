//
//  ViewController.swift
//  ss
//
//  Created by Abdalah Omar on 4/9/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import WebKit

class VRWebSiteCV: UIViewController ,WKNavigationDelegate {
    var urls = ""
     var location :VRWeb?
    var webView: WKWebView!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        location?.url = urls
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urls)!
           webView.load(URLRequest(url: url))
           webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
        
    }
}

