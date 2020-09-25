//
//  CellRestaurant.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/4/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Restaurant: Mappable {

    @objc dynamic var address: String?
    @objc dynamic var name: String?
    var cuisines: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var rating: String?
    @objc dynamic var onlineDelivery: Int = 0
    @objc dynamic var id: String?
    var review: Int?
    var favorite: Bool = false
    required convenience init?(map: Map) {
        self.init()
    }

    init() {
    }

    func mapping(map: Map) {
        var location: JSObject = [:]
        var userRating: JSObject = [:]
        location <- map["location"]
        userRating <- map["user_rating"]
        address = location["address"] as? String
        name <- map["name"]
        id <- map["id"]
        cuisines <- map["cuisines"]
        imageURL <- map["featured_image"]
        rating = userRating["aggregate_rating"] as? String
        onlineDelivery <- map["has_online_delivery"]
        review <- map ["all_reviews_count"]

    }
}
