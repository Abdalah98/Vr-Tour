//
//  HistorygramTableViewController.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/14/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import  Social
import FirebaseStorage
import Kingfisher
import  Firebase
class HistorygramViewController: UIViewController {
    @IBOutlet weak var tableviewHistory: UITableView!
    @IBOutlet weak var pickImages: UIBarButtonItem!
    let storage = Storage.storage()
    var selectedImage :UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
    // pickImages.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
     
        
        let fileName = NSUUID().uuidString
        
        guard let image = selectedImage else {return}
        guard let uploadedData = image.jpegData(compressionQuality: 0.5) else {return}
        
        let storageRef = Storage.storage().reference().child("postImages").child(fileName)
                
            storageRef.putData(uploadedData, metadata: nil) { (metaData, err) in
            if let err = err {
                print("upload post image error:", err)
                return
            }
            print("successfully uploaded post image")
            
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print("download post image url error:", err)
                        return
                    }
                    
                    guard let imageUrl = url?.absoluteString else {return}
                    self.savePostInfo(imageUrl: imageUrl)
                })
            
        }
        
        
}
    
    
    fileprivate func savePostInfo(imageUrl: String) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let image = selectedImage else {return}
        let databaseRef = Database.database().reference().child("posts").child(uid)
        let ref = databaseRef.childByAutoId()
        let values = [
            "imageUrl": imageUrl,
            "postDate": Date().timeIntervalSince1970,
            "imageWidth": image.size.width,
            "imageHeight": image.size.height
        ] as [String:Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("error adding post informations to database:", err)
                return
            }
            print("successfully adding post informations")
            self.dismiss(animated: true, completion: nil)
            let name = NSNotification.Name(rawValue: "loadPosts")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   var Array = ["caskpubkitchen.jpg","barrafina","bourkestreetbakery","cafeloisl","forkeerestaurant","bourkestreetbakery","bourkestreetbakery","upstate","bourkestreetbakery","grahamavenuemeats","bourkestreetbakery","royaloak","bourkestreetbakery","confessional","bourkestreetbakery"]
  
    @IBAction func pickImage(_ sender: Any) {

              
        
        // Display the share menu
        let PickImage = UIAlertController(title: "Pick Image", message: nil, preferredStyle: .actionSheet)
        let pickalbum = UIAlertAction(title: "Album", style: UIAlertAction.Style.default) { (action) in
         self.pickAnImage(sourceType : .photoLibrary)

        }
        let pickcamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default){ (action) in
            self.pickAnImage(sourceType : .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        PickImage.addAction(pickalbum)
        PickImage.addAction(pickcamera)
        PickImage.addAction(cancelAction)
        self.present(PickImage, animated: true, completion: nil)

        
        
        
    }
    @IBAction func CancelPressed(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    
    
    
   
}

    // MARK: - Table view data source

    extension HistorygramViewController : UITableViewDelegate , UITableViewDataSource{
           func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }

             func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return Array.count
            }

           
             func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfHistorygram", for: indexPath) as! HistorygramTableViewCell
                
                cell.imagePlace.image = UIImage(named:Array[indexPath.row])
                return cell
            }
        
        @IBAction func shar(_ sender: AnyObject) {
//let buttonPosition = sender.convert(CGPoint.zero, to: tableviewHistory)
//      guard let indexPath = tableviewHistory.indexPathForRow(at: buttonPosition) else {
//          return
//      }
//              // Display the share menu
//               let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
//               let twitterAction = UIAlertAction(title: "Twitter", style:
//               UIAlertAction.Style.default) { (action) in
//               // Check if Twitter is available. Otherwise, display an error message
//               guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
//               let alertMessage = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one.", preferredStyle: .alert)
//               alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                   self.present(alertMessage, animated: true, completion: nil); return
//               }
//                   // Display Tweet Composer
//                   if let tweetComposer = SLComposeViewController(forServiceType:
//               SLServiceTypeTwitter) {
//               tweetComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
//               tweetComposer.add(UIImage(named: self.Array[indexPath.row]))
//               self.present(tweetComposer, animated: true, completion: nil) }
//               }
//
//               let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertAction.Style.default) { (action) in
//               // Check if Facebook is available. Otherwise, display an error message
//               guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
//                       let alertMessage = UIAlertController(title: "Facebook Unavailable",
//                            message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one.", preferredStyle: .alert)
//               alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                   self.present(alertMessage, animated: true, completion: nil)
//                   return
//               }
//                   // Display Tweet Composer
//                   if let fbComposer = SLComposeViewController(forServiceType:
//               SLServiceTypeFacebook) {
//               fbComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
//                       fbComposer.add(UIImage(named: self.Array[indexPath.row]));
//                    self.present(fbComposer, animated: true, completion: nil)
//               } }
//
//               let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
//
//               shareMenu.addAction(twitterAction)
//               shareMenu.addAction(facebookAction)
//               shareMenu.addAction(cancelAction)
//
//               self.present(shareMenu, animated: true, completion: nil)
//           }
    
        }
}

extension HistorygramViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    func handelSelectimage(){
        let pikcer = UIImagePickerController()
        pikcer.allowsEditing = true
        pikcer.delegate = self
        present(pikcer,animated: true, completion: nil)

    }
   
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
           picker.dismiss(animated: true, completion: nil)
           
       }
    func pickAnImage(sourceType: UIImagePickerController.SourceType) {
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.sourceType = sourceType
          present(imagePickerController, animated: true, completion: nil)
      }
    // imagePickerView.image = image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = HistorygramTableViewCell()
        if let originalImage =  info[.originalImage] as? UIImage {
            cell.imagePlace.image = originalImage
            print("image")        }
        if let editedImage = info[.editedImage] as? UIImage {
            cell.imagePlace.image = editedImage
            print("image22")
        }
        dismiss(animated: true, completion: nil)
    }
}
