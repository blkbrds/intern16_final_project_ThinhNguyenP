//
//  Review.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/17/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class Review: Mappable {
    var rating: Int?
    var reviewsCount: Int?
    var like: Int?
    var commentCount: Int?
    var reviewTime: String?
    var reviewText: String?
    var ratingCount: Int?
    var user: User = User()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        user <- map["user"]
        rating <- map["rating"]
        like <- map["likes"]
        reviewsCount <- map["reviews_count"]
        commentCount <- map["comments_count"]
        reviewTime <- map["review_time_friendly"]
        reviewText <- map["review_text"]
        ratingCount <- map["reviews_start"]
    }
}
