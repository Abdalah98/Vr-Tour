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
   
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        location?.url = urls

        let url = URL(string: urls)!
           webView.load(URLRequest(url: url))
           webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    

    }
    override public var shouldAutorotate: Bool {
        return false
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }

    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
}

