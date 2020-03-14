//
//  LocationVr.swift
//  Vr Tour
//
//  Created by Abdalah Omar on 3/8/20.
//  Copyright © 2020 Hello Tomorrow. All rights reserved.
//

import Foundation
class LocationVr {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var rating = ""
    var AboutPlace = ""
   // var isliked = false
    
    init(name :String,type:String,location:String,image:String,isVisited:Bool,rating:String,AboutPlace:String) {
        self.name = name
        self.type = type
        self.location = location
        self.image  = image
        self.isVisited = isVisited
        self.rating = rating
        self.AboutPlace = AboutPlace
      //  self.isliked = isliked
    }
}
//,isliked:Bool
