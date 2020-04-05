  //
//  SharePhotoController.swift
//  Instagram Firebase
//
//  Created by Abdalah Omar on 3/31/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import Firebase
class SharePhotoController: UIViewController {
    @IBOutlet weak var ImageShare: UIImageView!
    var  selectedImage : UIImage?
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageShare.backgroundColor = .black
        ImageShare.contentMode = .scaleAspectFill
        // Do any additional setup after loading the view.
        ImageShare.image = selectedImage
        ImageShare.clipsToBounds = true 
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func BackAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ShareAction(_ sender: Any) {
        print("share")
        handelSare()
    }
  
      func handelSare(){
         

          guard let image = self.selectedImage else{
            print("error image")
            return}
          let fileName = NSUUID().uuidString
          guard let uploadedData = image.jpegData(compressionQuality: 0.5) else {
            print("error upload")
            return}
          shareBarButton.isEnabled = false
                         let storage = Storage.storage().reference().child("Share_Images").child(fileName)
                          storage.putData(uploadedData , metadata: nil) { (metadata, err) in
                             if let err = err {
                              self.shareBarButton.isEnabled = true

                             print("storge image ",err.localizedDescription)
                             return
                            }
                              let ImageUrl = storage
                            ImageUrl.downloadURL{ (url, err) in
                                if let err = err {
                                    print("download post image url error:", err)
                                    return
                                }
                               guard let imageUrl = url?.absoluteString else {return}
                              self.saveToDataBaseWithImageUrl(ImageUrl:imageUrl)
                               }
                              print("Succ uplaod pic",ImageUrl)
      }
    }
      fileprivate func  saveToDataBaseWithImageUrl(ImageUrl:String){
          guard let caption = self.captionTextView.text else{ return}
          guard let postimage = self.selectedImage else{ return}

          guard let uid = Auth.auth().currentUser?.uid  else { return}
          let userPostRef = Database.database().reference().child("posts").child(uid)
         let ref = userPostRef.childByAutoId()
          let value = ["imageUrl":ImageUrl,
                       "Caption" : caption,
                       "imageWidth" : postimage.size.width,
                       "imageHight" : postimage.size.height,
                       "creationDate" : Date().timeIntervalSince1970
              ] as [String : Any]
          ref.onDisconnectUpdateChildValues(value) { (err, ref) in
               if let err = err {
                  self.shareBarButton.isEnabled = true

             print("storge image ",err.localizedDescription)
                return
          }
              print("succ save in post to db")
              self.dismiss(animated: true, completion: nil)
          }
      }
  }
