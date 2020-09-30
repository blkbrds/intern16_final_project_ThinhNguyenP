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

@objcMembers class Restaurant: Object, Mappable {

    dynamic var id: String?
    dynamic var name: String?
    dynamic var imageURL: String?
    dynamic var rating: String?
    dynamic var onlineDelivery: Int = 0
    dynamic var favorite: Bool = false
    dynamic var location: Location?
    dynamic var establishment: List<String> = List<String>()

    var cuisines: String?
    var votes: Int?
    var timings: String?
    var phoneNumber: String?
    var url: String?
    var highlights: [String]?
    var review: Int?

    required init() { }

    required convenience init?(map: Map) {
        self.init()
    }

    init(
        id: String?,
        name: String?,
        imageURL: String?,
        rating: String?,
        onlineDelivery: Int,
        favorite: Bool,
        location: Location?,
        establishment: List<String>
    ) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.onlineDelivery = onlineDelivery
        self.favorite = favorite
        self.location = location
        self.establishment = establishment
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override class func ignoredProperties() -> [String] {
        return ["cuisines", "votes", "timings", "phoneNumber", "url", "highlights", "review"]
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
        establishment <- map["establishment"]
    }
}
