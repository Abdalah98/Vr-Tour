//
//  PhotoSelectorCell.swift
//  Instagram Firebase
//
//  Created by Abdalah Omar on 3/30/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit

class PhotoSelectorCell: UICollectionViewCell {
    @IBOutlet weak var imageShow: UIImageView!
   
    override func awakeFromNib() {
                    super.awakeFromNib()
        imageShow.contentMode = .scaleAspectFill
           imageShow.clipsToBounds  = true
    }

}

