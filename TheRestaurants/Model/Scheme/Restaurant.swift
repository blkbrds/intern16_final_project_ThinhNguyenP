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

    var name: String?
    var cuisines: String?
    var imageURL: String?
    var rating: String?
    var votes: Int?
    var onlineDelivery: Int?
    var id: String?
    var timings: String?
    var phoneNumber: String?
    var url: String?
    var highlights: [String]?
    var review: Int?
    var location: Location = Location()
    var favorite: Bool = false
    required convenience init?(map: Map) {
        self.init()
    }

    init() {
    }

    func mapping(map: Map) {
        var userRating: JSObject = [:]
        location <- map["location"]
        userRating <- map["user_rating"]
        name <- map["name"]
        id <- map["id"]
        cuisines <- map["cuisines"]
        imageURL <- map["featured_image"]
        rating = userRating["aggregate_rating"] as? String
        onlineDelivery <- map["has_online_delivery"]
        review <- map ["all_reviews_count"]
    }
}
