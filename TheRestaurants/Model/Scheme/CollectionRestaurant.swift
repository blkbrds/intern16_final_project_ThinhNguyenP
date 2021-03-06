//
//  Collection.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

final class Collection: Mappable {

    var countPlaces: Int?
    var title: String?
    var imageUrl: String?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        title <- map["title"]
        countPlaces <- map ["res_count"]
        imageUrl <- map ["image_url"]
    }
}
