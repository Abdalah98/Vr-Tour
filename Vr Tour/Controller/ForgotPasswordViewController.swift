//
//  ForgotPasswordViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var ForgotPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let mailImage = UIImage(named:"mail")
        addLeftImageTo(txtField: ForgotPassword, andImage: mailImage!)
        
        
        ForgotPassword.delegate = self
    }
    func addLeftImageTo(txtField: UITextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }

}
