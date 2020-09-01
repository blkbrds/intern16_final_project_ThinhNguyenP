//
//  Collection.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

@objcMembers class CollecitonRestaurant: Mappable {

    var countPlaces: Int = 12
    var title: String = ""
    var imageCollection: String = ""
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        title <- map["title"]
        countPlaces <- map ["res_count"]
        imageCollection <- map ["image_url"]
    }
}
