//
//  HomeCellModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/4/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class HomeCellModel {

    var address: String?
    var name: String?
    var cuisines: String?
    var imageURL: String?
    var rating: String?
    var onlineDelivery: Int?
    var isFavorite = true
    var id: String?
    var cuisineArr: [String] {
        guard let cuisineStr = cuisines else { return [] }
        return ["Cuisine"] + cuisineStr.split(separator: ",").map { String($0) }
    }

    init(restaurant: Restaurant) {
        address = restaurant.location?.address
        name = restaurant.name
        cuisines = restaurant.cuisines
        let imageURL = restaurant.imageURL ?? ""
        self.imageURL = imageURL.replacingOccurrences(of: "?output-format=webp", with: "")
        rating = restaurant.rating
        onlineDelivery = restaurant.onlineDelivery
        isFavorite = restaurant.favorite
        id = restaurant.id
    }
}
