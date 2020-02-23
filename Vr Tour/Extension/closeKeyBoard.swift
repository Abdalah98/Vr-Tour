//
//  closeKeyBoard.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 2/23/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import Foundation
import  UIKit
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
