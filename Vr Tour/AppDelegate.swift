//
//  AppDelegate.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/21/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FacebookCore

import SCLAlertView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate func checkUser(){
        if Auth.auth().currentUser?.uid != nil{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "GoToMap") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
               IQKeyboardManager.shared.enableAutoToolbar = false
               IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions);
        FirebaseApp.configure()
       checkUser()
        return true
    }

    func application(_ app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance().handle(url)

        return ApplicationDelegate.shared.application(
            app,
            open: url,
            options: options
        )
    }
}


