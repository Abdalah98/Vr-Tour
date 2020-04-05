//
//  HistoryCollectionViewCell.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 4/3/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit
import Kingfisher
import Social
class HistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var liked: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    var user : User? {
        didSet{
            guard let profileImageUrl  = user?.profileImageUrl else {return }
            guard  let url = URL(string :profileImageUrl)else{return}
            if url.absoluteString != self.user?.profileImageUrl{return}
            name.text = user?.userName
            DispatchQueue.main.async {
                self.imageprofile?.kf.setImage(with: url)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagePlace.clipsToBounds  = true
                     imagePlace.backgroundColor = .yellow
        imageprofile.layer.cornerRadius = 40/2
              imageprofile.contentMode = .scaleAspectFill
              imageprofile.clipsToBounds = true
             imageprofile?.backgroundColor = .blue
              imagePlace.contentMode = .scaleAspectFill
             
    }
    
    
    
    var isLiked :Bool = true
   
    
    @IBAction func likedPicture(_ sender: UIButton) {
        isLiked = !isLiked
                 if isLiked {
                     liked.setImage(UIImage(named: "favoritefill"), for: .normal)
                 } else {
                     liked.setImage(UIImage(named: "favorite"), for: .normal)
                 }

    }
    
    
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        
//        if let fbComposer = SLComposeViewController(forServiceType:
//                           SLServiceTypeFacebook) {
//                           fbComposer.setInitialText("Having lunch at " + self.Array[indexPath.row])
//            fbComposer.add(UIImage(named: self.Array[indexPath.row]));
//    }
    
}
}
