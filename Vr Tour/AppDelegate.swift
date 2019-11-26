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
import FBSDKCoreKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SCLAlertView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
      
      
        return true
    }
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
   
}


