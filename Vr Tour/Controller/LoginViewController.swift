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
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    @IBAction func LogIn(_ sender: Any) {
      Login()
    }
    
    
    @IBAction func onClickFacebookLoginButton(_ sender: UIButton) {
    
    }
    
    
    //MARK:- FireBase
    func Login(){
        if emailText.text!.isEmpty || passwordText.text!.isEmpty {
            SCLAlertView().showError("Error", subTitle:"Some field is empty", closeButtonTitle:"Ok")
        } else {
            
            Auth.auth().signIn(withEmail: emailText.text!,password: passwordText.text!) { (user, error) in
                if (error == nil)  {
                    print("log is true")
                    UserDefaults.standard.set(self.emailText.text!, forKey: "email")
                    UserDefaults.standard.synchronize()
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap")
                    self.present(viewController!, animated: true, completion: nil)
                    SCLAlertView().showSuccess("Success ", subTitle:"Log In success", closeButtonTitle:"Ok")
                    
                    
                }else {
                    print("log in error")
                    SCLAlertView().showError("Error", subTitle: (error?.localizedDescription)!, closeButtonTitle:"Ok")
                }
            }
            
            
        }
    }
}

