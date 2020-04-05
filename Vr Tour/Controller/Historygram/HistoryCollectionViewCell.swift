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
import FacebookShare
class HistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageprofile: UIImageView!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var liked: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    var post : PostDetails? {
        didSet{
            guard let profileImageUrl  = post?.imageUrl else {return }
            guard  let url = URL(string :profileImageUrl)else{return}
            if url.absoluteString != self.post?.imageUrl {return}
            name.text = post?.user?.userName
            caption.text = post?.Caption
            guard let profileImageUrls  = post?.user?.profileImageUrl else {return }
             guard  let urls = URL(string :profileImageUrls)else{return}
            DispatchQueue.main.async {
                self.imagePlace?.kf.setImage(with: url)
                self.imageprofile?.kf.setImage(with: urls)

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
    
    
    
    
 
}

