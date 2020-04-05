//
//  PhotoSelectorReusableView.swift
//  Instagram Firebase
//
//  Created by Abdalah Omar on 3/30/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit

class PhotoSelectorReusableView: UICollectionReusableView {
    @IBOutlet weak var headerImage: UIImageView!

        override func awakeFromNib() {
               super.awakeFromNib()
            headerImage.contentMode = .scaleAspectFit
             headerImage.clipsToBounds  = true
               //
          
           }

}
