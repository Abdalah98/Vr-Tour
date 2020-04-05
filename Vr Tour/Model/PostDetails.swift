//
//  PostDetails.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 4/5/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import Foundation

struct PostDetails {
    var Caption: String?
    var creationDate: Double?
    var imageHight: Int?
    var imageUrl: String?
    var imageWidth: Int?
    let user :User?
    init(user:User,dictionary:[String:Any]) {
        self.Caption = dictionary["Caption"] as? String ?? ""
        self.creationDate = dictionary["creationDate"] as? Double ?? 0.0
        self.imageHight = dictionary["imageHight"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.imageWidth = dictionary["imageWidth"] as? Int ?? 0
        self.user = user

    }
}
