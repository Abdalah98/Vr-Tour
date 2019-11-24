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
                if error != nil  {
                    
                   SCLAlertView().showError("Error", subTitle:"User already exists", closeButtonTitle:"Ok")
                    
                }else {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap")
                    self.present(viewController!, animated: true, completion: nil)
                    SCLAlertView().showSuccess("Success ", subTitle:"is added successfully", closeButtonTitle:"Ok")

                }
            }

            
        }
    }
    }

    
   

}
//    let questionBagVC = storyboard?.instantiateViewController(withIdentifier: "Map")
//    navigationController?.pushViewController(questionBagVC!, animated: true)
//MARK:- EXTENSION
extension SignUpViewController:UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
  
    
    
}
