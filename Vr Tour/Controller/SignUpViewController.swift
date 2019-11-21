//
//  SignUpViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        addImageToTextField()
    }
    
    
    
    //MARK:- TextField
    func addImageToTextField(){
        let nameImage = UIImage(named:"Name")
        addLeftImageTo(txtField: Name, andImage: nameImage!)
        
        let emailImage = UIImage(named:"mail")
        addLeftImageTo(txtField: Email, andImage: emailImage!)
        
        let confirmpassImage = UIImage(named:"pass")
        addLeftImageTo(txtField: Password, andImage: confirmpassImage!)
        
        let passwordImage = UIImage(named:"pass")
        addLeftImageTo(txtField: confirmPassword, andImage: passwordImage!)
        
       
        Name.delegate = self
        Email.delegate = self
        Password.delegate = self
        confirmPassword.delegate = self
    }
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    

}
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
