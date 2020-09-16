//
//  CellRestaurant.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/4/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class Restaurant: Mappable {

    var address: String?
    var name: String?
    var cuisines: String?
    var imageURL: String?
    var rating: String?
    var onlineDelivery: Int?
    var id: String?
    var favorite: Bool = false
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        var location: JSObject = [:]
        var userRating: JSObject = [:]
        location <- map["location"]
        userRating <- map["user_rating"]
        address = location["address"] as? String
        name <- map["name"]
        cuisines <- map["cuisines"]
        imageURL <- map["featured_image"]
        id <- map["id"]
        rating = userRating["aggregate_rating"] as? String
        onlineDelivery <- map["has_online_delivery"]
    }
}
