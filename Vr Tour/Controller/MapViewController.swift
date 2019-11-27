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
import FirebaseDatabase
import Firebase
class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       authenticateUserAndConfigureView()
        // Do any additional setup after loading the view.
    }
    
   func authenticateUserAndConfigureView() {
         if Auth.auth().currentUser == nil {
             DispatchQueue.main.async {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToLogin")
                              self.present(viewController!, animated: true, completion: nil)
             }
         } else {
          
             loadUserData()
         }
     }
    func loadUserData() {
          guard let uid = Auth.auth().currentUser?.uid else { return }
          Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard (snapshot.value as? String) != nil else { return }
             
          }
      }
      

}
