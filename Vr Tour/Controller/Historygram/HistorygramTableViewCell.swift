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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
