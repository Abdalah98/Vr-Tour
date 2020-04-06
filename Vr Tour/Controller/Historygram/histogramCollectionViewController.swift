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
import FacebookShare
private let reuseIdentifier = "Historgram"

class histogramCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
        fetchUser()
        // collectionView.backgroundColor = .yellow
        collectionView.reloadData()
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
        cell.post =  posts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 400)
    }
    var posts = [PostDetails]()
   // var user = [User]()
    
    
    
    
    
    var user :User?
    fileprivate func fetchUser(){
     guard let uid = Auth.auth().currentUser?.uid else{return}
     Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value
         , with: { (snapshot) in
             print("value is: ", snapshot.value ?? "" )
             guard let dictionary = snapshot.value as? [String:Any] else{return}

             self.user = User(dictionary: dictionary)
//        print(self.user?.userName, "----", self.user?.email, "----", self.user?.profileImageUrl, "---", self.user?.id)
          //   self.navigationItem.title = self.user?.userName
             self.collectionView.reloadData()
     }) { (err) in
         print(err.localizedDescription)
     }

     }
    
    
    
    
    fileprivate func fetchPost(){
        guard let uid = Auth.auth().currentUser?.uid  else { return}
           Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value
                 , with: { (snapshot) in
                     guard let dictionary = snapshot.value as? [String:Any] else{return}

                    self.user = User(dictionary: dictionary)
      let ref = Database.database().reference().child("posts").child(uid)
           ref.observeSingleEvent(of: .value, with: { (snapshot) in
               guard let dictionaries = snapshot.value as? [String:Any] else { return}
               dictionaries.forEach { (key,value) in
                
                   guard let dictionary = value as? [String:Any]else { return}
                   

                let post = PostDetails( user: self.user!, dictionary: dictionary)
                   self.posts.append(post)
                   self.collectionView.reloadData()
                   
               }
           }) { (err) in
               print(err.localizedDescription)
               
           }
                     self.collectionView.reloadData()
             }) { (err) in
                 print(err.localizedDescription)
             }
        
       self.collectionView.reloadData()
        
    }

    
}
 
    

