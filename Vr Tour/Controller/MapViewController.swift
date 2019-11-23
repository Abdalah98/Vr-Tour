//
//  MapViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView
class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch{
            SCLAlertView().showError("Error", subTitle:"There was a problem siging out check internet connection", closeButtonTitle:"Ok")

        }
    }


}
