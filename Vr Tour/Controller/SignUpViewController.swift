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
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
class SignUpViewController: UIViewController , GIDSignInDelegate{

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
 GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
  GIDSignIn.sharedInstance()?.presentingViewController = self
      GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func SignUp(_ sender: Any) {
       siginUp()
    }

    @IBAction func onClickFacebookLoginButton(_ sender: UIButton) {
         LoginFacebook()
      }
      
    
    
      //MARK:- FireBase Google
   //  Present a sign-in with Google window
      @IBAction func googleSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
      }
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



extension SignUpViewController:UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
  
    
    
}
