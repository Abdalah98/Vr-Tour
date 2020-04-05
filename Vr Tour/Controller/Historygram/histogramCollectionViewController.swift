//
//  histogramCollectionViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 4/4/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import Social
private let reuseIdentifier = "Historgram"

class histogramCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
        // collectionView.backgroundColor = .yellow
    }
    
    @IBAction func cnacelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryCollectionViewCell
        let url = URL(string: posts[indexPath.item].imageUrl ?? "")
        cell.imagePlace.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 400)
    }
    var posts = [PostDetails]()
    var user = [User]()
    fileprivate func fetchPost(){
        guard let uid = Auth.auth().currentUser?.uid  else { return}
        
        let userRef = Database.database().reference().child("users").child(uid)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value as Any)
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            dictionary.forEach { (key, value) in
                print("Key\(key), value\(value)")
                guard let dictionary = value as? [String:Any] else {return}
                let user = User(dictionary: dictionary)
                self.user.append(user)
                self.collectionView.reloadData()
            }
        }
        
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print("the value is : ", snapshot.value as Any)
            guard let dictionaries = snapshot.value as? [String:Any] else { return}
            dictionaries.forEach { (key,value) in
                print("Key\(key), value\(value)")
                guard let dictionary = value as? [String:Any]else { return}
                //                let imageUrl = dictionary["imageUrl"] as?String
                //                print(imageUrl)
               // let user = User(dictionary: dictionary)

                let post = PostDetails( dictionary: dictionary)
                self.posts.append(post)
                self.collectionView.reloadData()
                
            }
        }) { (err) in
            print(err.localizedDescription)
            
        }
        
    }
    
    
//            @IBAction func shar(_ sender: AnyObject) {
//    let buttonPosition = sender.convert(CGPoint.zero, to: collectionView)
//          guard let indexPath = collectionView.indexPath(for: buttonPosition) else {
//              return
//          }
//                  // Display the share menu
//                   let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
//                   let twitterAction = UIAlertAction(title: "Twitter", style:
//                   UIAlertAction.Style.default) { (action) in
//                   // Check if Twitter is available. Otherwise, display an error message
//                   guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
//                   let alertMessage = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one.", preferredStyle: .alert)
//                   alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                       self.present(alertMessage, animated: true, completion: nil); return
//                   }
//                       // Display Tweet Composer
//                       if let tweetComposer = SLComposeViewController(forServiceType:SLServiceTypeTwitter) {
//                   tweetComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
//                   tweetComposer.add(UIImage(named: self.Array[indexPath.row]))
//                   self.present(tweetComposer, animated: true, completion: nil) }
//                   }
//    
//                   let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertAction.Style.default) { (action) in
//                   // Check if Facebook is available. Otherwise, display an error message
//                   guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
//                           let alertMessage = UIAlertController(title: "Facebook Unavailable",
//                                message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one.", preferredStyle: .alert)
//                   alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                       self.present(alertMessage, animated: true, completion: nil)
//                       return
//                   }
//                       // Display Tweet Composer
//                       if let fbComposer = SLComposeViewController(forServiceType:
//                   SLServiceTypeFacebook) {
//                   fbComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
//                           fbComposer.add(UIImage(named: self.Array[indexPath.row]));
//                        self.present(fbComposer, animated: true, completion: nil)
//                   } }
//    
//                   let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
//    
//                   shareMenu.addAction(twitterAction)
//                   shareMenu.addAction(facebookAction)
//                   shareMenu.addAction(cancelAction)
//    
//                   self.present(shareMenu, animated: true, completion: nil)
//               }
//    
            }
 
    

