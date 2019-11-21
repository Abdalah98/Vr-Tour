//
//  ViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let emailImage = UIImage(named:"Mail")
//        addLeftImageTo(txtField: emailText, andImage: emailImage!)
//        let passwordlImage = UIImage(named:"Pass")
//        addLeftImageTo(txtField: passwordText, andImage: passwordlImage!)
//
//        
//        emailText.delegate = self
//        passwordText.delegate = self
        
    }
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
}

