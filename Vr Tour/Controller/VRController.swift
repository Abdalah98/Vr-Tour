//
//  ViewController.swift
//  CTPanoramaView
//
//  Created by Cihan Tek on 12/10/2016.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import CTPanoramaView
class VRController: UIViewController {
  
    @IBOutlet weak var compassView: CTPieSliceView!
    @IBOutlet weak var panoramaView: CTPanoramaView!
     override func viewWillAppear(_ animated: Bool) {
       
       
    } 
    override func viewDidLoad() {
        super.viewDidLoad()
//         let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
        
        loadSphericalImage()
        panoramaView.compass = compassView
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
    @IBAction func panoramaTypeTapped() {
        if panoramaView.panoramaType == .spherical {
            loadCylindricalImage()
        } else {
            loadSphericalImage()
        }
    }

    @IBAction func motionTypeTapped() {
        if panoramaView.controlMethod == .touch {
            panoramaView.controlMethod = .motion
        } else {
            panoramaView.controlMethod = .touch
        }
    }

    func loadSphericalImage() {
        panoramaView.image = UIImage(named: "ms.JPG")
    }

    func loadCylindricalImage() {
        panoramaView.image = UIImage(named: "ms.JPG")
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .all
//    }
}
