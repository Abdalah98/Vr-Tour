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
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseDatabase
import SVProgressHUD
class SignUpViewController: UIViewController , GIDSignInDelegate{

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      self.hideKeyboardWhenTappedAround()

 GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
  GIDSignIn.sharedInstance()?.presentingViewController = self
      GIDSignIn.sharedInstance().delegate = self
    }
    
    
    
    //MARK: - GetPressedSignUp
    
    @IBAction func SignUp(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Loading...")

        if Name.text!.isEmpty || Email.text!.isEmpty || Password.text!.isEmpty ||
                    confirmPassword.text!.isEmpty{
                      SCLAlertView().showError("Error", subTitle:"Some field is empty", closeButtonTitle:"Ok")
            SVProgressHUD.dismiss()

        }else{
            if ((self.Password.text?.elementsEqual(self.confirmPassword.text!))! != true)
            {  SCLAlertView().showError("Error", subTitle:"Passwords do not match", closeButtonTitle:"Ok")
                SVProgressHUD.dismiss()

                
            }else{
        createUser(withEmail: Email.text!, password: Password.text!, username: Name.text!)
         }
        }
    }
    
    
    
    
    
    
    //MARK: - GetPressedSignUpWithFacebook

    
    @IBAction func onClickFacebookLoginButton(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "Loading...")

         LoginFacebook()
      }
      
    
    //MARK: - GetPressedSignUpWithGoogleFacebook

    
      @IBAction func googleSignIn(sender: AnyObject) {
        SVProgressHUD.show(withStatus: "Loading...")

        GIDSignIn.sharedInstance().signIn()
      }
   
    
    
    
    
       //MARK:- FireBase siginUp()

    
    
    func createUser(withEmail email: String, password: String, username: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            SVProgressHUD.dismiss()

            if let error = error {
                print("Failed to sign user up with error: ", error.localizedDescription)
                    SCLAlertView().showError("Error", subTitle:(error.localizedDescription), closeButtonTitle:"Ok")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email, "username": username]

           Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error {
                    SVProgressHUD.dismiss()

                    print("Failed to update database values with error: ", error.localizedDescription)
                    SCLAlertView().showError("Error", subTitle:(error.localizedDescription), closeButtonTitle:"Ok")

                    return
                }
                SVProgressHUD.dismiss()

                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap")
                                         self.present(viewController!, animated: true, completion: nil)
                                         SCLAlertView().showSuccess("Success ", subTitle:"is added successfully", closeButtonTitle:"Ok")
            })
            
        }
        
    }
    
   
  
     //MARK:- FireBase Google

     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
         print("Google Sing In didSignInForUser")
         SVProgressHUD.dismiss()

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
                     SVProgressHUD.dismiss()

                   print("Login error: \(error.localizedDescription)")
                     let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                     let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                     alertController.addAction(okayAction)
                     self.present(alertController, animated: true, completion: nil)

                      return
                    }
             SVProgressHUD.dismiss()

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
                        SVProgressHUD.dismiss()

                          print("Failed to login: \(error.localizedDescription)")

                          return
                      }
                      
                    guard let accessToken = AccessToken.current else {
                        SVProgressHUD.dismiss()

                          print("Failed to get access token")
                          return
                      }
                      
                    let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                      
                      // Perform login by calling Firebase APIs
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                          if let error = error {
                             SVProgressHUD.dismiss()

                              print("Login error: \(error.localizedDescription)")
                              let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                              let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                              alertController.addAction(okayAction)
                              self.present(alertController, animated: true, completion: nil)
                              
                              return
                          }
                          SVProgressHUD.dismiss()

                          // Present the main view
                          if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToMap") {
                              UIApplication.shared.keyWindow?.rootViewController = viewController
                              self.dismiss(animated: true, completion: nil)
                          }
                          
                      })
                      
                  }
     }
}



