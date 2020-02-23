//
//  ForgotPasswordViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SCLAlertView
import SVProgressHUD
class ForgotPasswordViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var ForgotPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "ForgotPassword"
        self.hideKeyboardWhenTappedAround()

        self.hideKeyboardWhenTappedAround()

    }
  
    @IBAction func Sendpassword(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")

        if ForgotPassword.text!.isEmpty  {
            SCLAlertView().showError("Error", subTitle:"Some field is empty", closeButtonTitle:"Ok")
            SVProgressHUD.dismiss()

        } else {
            resetPassword(email: ForgotPassword.text!)
        }
    }
    
    
    //MARK:- FireBase

    private func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            SVProgressHUD.dismiss()

            if(error != nil) {
                SCLAlertView().showError("Error", subTitle:(error?.localizedDescription)!, closeButtonTitle:"Try again")
            }
            else {
                SVProgressHUD.dismiss()

                 let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToLogin")
                self.present(viewController!, animated: true, completion: nil)

               SCLAlertView().showSuccess("Success", subTitle:"Password reset email sent check you mail", closeButtonTitle:"Ok")
               
                
            }
            
            
        })
    }
    
    
    
  

}
