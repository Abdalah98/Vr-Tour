//
//  ViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
class LoginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }
    
    @IBAction func LogIn(_ sender: Any) {
        if emailText.text!.isEmpty || passwordText.text!.isEmpty {
            SCLAlertView().showError("Error", subTitle:"Some field is empty", closeButtonTitle:"Ok")
        } else {
            
            Auth.auth().signIn(withEmail: emailText.text!,password: passwordText.text!) { (user, error) in
                if error != nil  {
                    
                    SCLAlertView().showError("Error", subTitle:"Email or Password error", closeButtonTitle:"Ok")
                    
                }else {
                    
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap")
                    self.present(viewController!, animated: true, completion: nil)
                    SCLAlertView().showSuccess("Success ", subTitle:"Log In success", closeButtonTitle:"Ok")
                }
            }
            
            
        }
    }
}

//    let questionBagVC = storyboard?.instantiateViewController(withIdentifier: "Map")
//    navigationController?.pushViewController(questionBagVC!, animated: true)
