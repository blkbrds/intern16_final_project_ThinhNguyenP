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

    @objc dynamic var name: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var rating: String?
    @objc dynamic var onlineDelivery: Int = 0
    @objc dynamic var id: String?
    var cuisines: String?
    var votes: Int?
    var timings: String?
    var phoneNumber: String?
    var url: String?
    var highlights: [String]?
    var review: Int?
    var location: Location = Location()
    var favorite: Bool = false

    init() { }

    required convenience init?(map: Map) {
        self.init()
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
        timings <- map["timings"]
        phoneNumber <- map["phone_numbers"]
        url <- map["url"]
        highlights <- map["highlights"]
    }
}
