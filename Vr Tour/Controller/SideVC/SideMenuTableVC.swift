//
//  SideMenuTableVC.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 11/25/19.
//  Copyright © 2019 Hello Tomorrow. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import FirebaseAuth
class SideMenuTableVC: UITableViewController {

    @IBOutlet var sidemenu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     sidemenu.separatorColor = .black

    }

    @IBAction func signOut(_ sender: Any) {
        if(Auth.auth().currentUser != nil){
        do {
            try Auth.auth().signOut()
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToLogin")
                present(viewController!, animated: true, completion: nil)
             }catch let error as NSError {
                print(error.localizedDescription)
            SCLAlertView().showError("Error",subTitle:(error.localizedDescription), closeButtonTitle:"Ok")
                         }
                     }
    }
    
    @IBAction func GetPressedWeather(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToWeather")
                       present(viewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func CurrencyExchange(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "goCurrencyExchange")
        present(viewController!, animated: true, completion: nil)
        
    }
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
      footerView.backgroundColor = .cyan

      return footerView
  }

}
