//
//  Users.swift
//  Instagram Firebase
//
//  Created by Abdalah Omar on 3/29/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import Foundation
struct User {
    let userName:String
    let profileImageUrl :String
    var email: String
    var id: String
    init(dictionary:[String:Any]) {
        self.userName = dictionary["username"] as? String ?? ""
        self.profileImageUrl =  dictionary["profileImage"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
    }
}

