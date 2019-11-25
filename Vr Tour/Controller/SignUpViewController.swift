//
//  SignUpViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
 
    }
    
    @IBAction func SignUp(_ sender: Any) {
       siginUp()
    }

    
    
    
    
    //MARK:- FireBase
    //MARK:- FireBase siginUp()

    func siginUp(){
        if Name.text!.isEmpty || Email.text!.isEmpty || Password.text!.isEmpty ||
            confirmPassword.text!.isEmpty{
            SCLAlertView().showError("Error", subTitle:"Some field is empty", closeButtonTitle:"Ok")
        } else {
            if ((self.Password.text?.elementsEqual(self.confirmPassword.text!))! != true)
            {
                SCLAlertView().showError("Error", subTitle:"Passwords do not match", closeButtonTitle:"Ok")
                
                return
            }else{
                Auth.auth().createUser(withEmail: Email.text!,password: Password.text!) { (user, error) in
                    if (error == nil)  {
                        print("Signup successfull")
                        
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap")
                        self.present(viewController!, animated: true, completion: nil)
                        SCLAlertView().showSuccess("Success ", subTitle:"is added successfully", closeButtonTitle:"Ok")
                        
                    }else {
                        
                        SCLAlertView().showError("Error", subTitle:(error?.localizedDescription)!, closeButtonTitle:"Ok")
                        
                    }
                }
                
                
            }
        }
    }
    func setRootViewController() {
        if Auth.auth().currentUser != nil {
            // Set Your home view controller Here as root View Controller
            let viewController = storyboard?.instantiateViewController(withIdentifier: "GoToMap")
            self.present(viewController!, animated: true, completion: nil)
        } else {
            // Set you login view controller here as root view controller
            let viewController = storyboard?.instantiateViewController(withIdentifier: "GoToLogin")
            self.present(viewController!, animated: true, completion: nil)
        }
    }

}

extension SignUpViewController:UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
  
    
    
}
