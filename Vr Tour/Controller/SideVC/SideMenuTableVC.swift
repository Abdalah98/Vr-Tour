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
class SideMenuTableVC: UITableViewController {
    
    @IBOutlet weak var ImageProfile: UIImageView!
    
    @IBOutlet weak var nameProfile: UILabel!
    
    @IBOutlet var sidemenu: UITableView!{
        didSet {
            sidemenu.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()

        setUpProfileImage()
        fetchUser()
        sidemenu.separatorColor = .black
        ImageProfile.layer.cornerRadius = 80/2
        ImageProfile.clipsToBounds = true
        
    }
    
    //MARK: - GetPressedWeather
    
    @IBAction func GetPressedWeather(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GoToWeather")
        present(viewController!, animated: true, completion: nil)
    }
    
    //MARK: - GetPressedCurrencyExchange
    
    
    @IBAction func CurrencyExchange(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "goCurrencyExchange")
        present(viewController!, animated: true, completion: nil)
        
    }
    
    
    //MARK: - GetPressedWeather
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = .cyan
        
        return footerView
    }
    
    
    
    //MARK: - GetPressedLocationVr
    
    @IBAction func PressdLocationVr(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "locationVr")
        present(viewController!, animated: true, completion: nil)
    }
    
    //MARK: - GetPressednearbyPlace
    
    @IBAction func nearbyPlace(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "GonearbyPlace")
        present(viewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func Historygram(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "goHistoryGram")
        present(viewController!, animated: true, completion: nil)
    }
    
    @IBAction func VRwebSiteAction(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "goVRwebsite")
               present(viewController!, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: - GetPressedsignOut
    
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
    var user :User?{
        didSet{
            setUpProfileImage()
        }
    }
    
    fileprivate func setUpProfileImage() {
        self.tableView.reloadData()

        guard let ImageProfile  = user?.profileImageUrl else {return }
        
        guard  let url = URL(string :ImageProfile)else{return}
        
        self.ImageProfile.kf.setImage(with: url)
        
    }
    fileprivate func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value
            , with: { (snapshot) in
                print("value is: ", snapshot.value ?? "" )
                guard let dictionary = snapshot.value as? [String:Any] else{return}
//                let rateView = dictionary["username"] as? String
//                print(rateView)
                self.user = User(dictionary: dictionary)
                self.tableView.reloadData()

             //   print(self.user?.userName, "----", self.user?.email, "----", self.user?.profileImageUrl, "---", self.user?.id)
                self.navigationItem.title = self.user?.userName
                
                self.nameProfile.text = self.user?.userName
        }) { (err) in
            print(err.localizedDescription)
        }
        
    }
}
