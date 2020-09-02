//
//  Cell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/1/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class CellRestaurant: Mappable {

    var address: String?
    var name: String?
    var cuisines: String?
    var imageURL: String?
    var rating: String?
    var onlineDelivery: String?

    required convenience init?(map: Map) {
        self.init()
    }

     func mapping(map: Map) {
        address <- map["address"]
        name <- map["name"]
        cuisines <- map["cuisines"]
        imageURL <- map["url"]
        rating <- map["aggregate_rating"]
        onlineDelivery <- map["has_online_delivery"]
    }
}
