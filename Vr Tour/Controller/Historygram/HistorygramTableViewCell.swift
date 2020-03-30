//
//  HistorygramTableViewCell.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/14/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import UIKit

class HistorygramTableViewCell: UITableViewCell {

  @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var liked: UIButton!
    @IBOutlet weak var share: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var isLiked :Bool = true
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likedPicture(_ sender: UIButton) {
        isLiked = !isLiked
                 if isLiked {
                     liked.setImage(UIImage(named: "favoritefill"), for: .normal)
                 } else {
                     liked.setImage(UIImage(named: "favorite"), for: .normal)
                 }

    }
    
}
