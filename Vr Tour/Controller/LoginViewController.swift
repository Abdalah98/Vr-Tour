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
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
class LoginViewController: UIViewController ,UITextFieldDelegate , GIDSignInDelegate{
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
      let loginButton = FBLoginButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
     GIDSignIn.sharedInstance()?.presentingViewController = self
 
        GIDSignIn.sharedInstance().delegate = self

    }
    
    @IBAction func LogIn(_ sender: Any) {
      Login()
    }
    
    
    @IBAction func onClickFacebookLoginButton(_ sender: UIButton) {
       LoginFacebook()
    }
    


    @IBAction func onClickGoogleLoginButton(_ sender: Any) {
        
      GIDSignIn.sharedInstance().signIn()
       
    }
    
    
    //MARK:- FireBase
    //MARK:- FireBase Login

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
  
    
    
    //MARK:- FireBase Google

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("Google Sing In didSignInForUser")
                 if let error = error {
               print("Failed to login: \(error.localizedDescription)")
                   return
                 }

         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
         print("Failed to get access token")
         Auth.auth().signIn(with: credential, completion: { (user, error) in
                   if let error = error {

                  print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)

                     return
                   }
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap") {
                                        UIApplication.shared.keyWindow?.rootViewController = viewController
                                        self.dismiss(animated: true, completion: nil)
                                    }
                 })
               }


       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
      GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
       }
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {

      // Showing OAuth2 authentication window
      if let aController = viewController {
        present(aController, animated: true) {() -> Void in }
      }
    }
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
      // Close OAuth2 authentication window
      dismiss(animated: true) {() -> Void in }
    }
    
    

    //MARK:- FireBase LoginFacebook
    func LoginFacebook(){
        let fbLoginManager = LoginManager()
               fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                     if let error = error {
                         print("Failed to login: \(error.localizedDescription)")
                       
                         return
                     }
                     
                   guard let accessToken = AccessToken.current else {
                         print("Failed to get access token")
                         return
                     }
                     
                   let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                     
                     // Perform login by calling Firebase APIs
                   Auth.auth().signIn(with: credential, completion: { (user, error) in
                         if let error = error {
                             print("Login error: \(error.localizedDescription)")
                             let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                             let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                             alertController.addAction(okayAction)
                             self.present(alertController, animated: true, completion: nil)
                             
                             return
                         }
                         
                         // Present the main view
                         if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap") {
                             UIApplication.shared.keyWindow?.rootViewController = viewController
                             self.dismiss(animated: true, completion: nil)
                         }
                         
                     })
                     
                 }
    }
}

