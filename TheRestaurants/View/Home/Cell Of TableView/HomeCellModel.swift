//
//  HomeCellModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/4/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import UIKit

class HomeCellModel {

    var address: String?
    var name: String?
    var cuisines: String?
    var imageURL: String?
    var rating: String?
    var onlineDelivery: Int?
    var isFavorite: Bool

    var cuisineArr: [String] {
        guard let cuisineStr = cuisines else { return [] }
        return ["Cuisine"] + cuisineStr.split(separator: ",").map { String($0) }
    }

    init(cellsRestaurant: Restaurant) {
        self.address = cellsRestaurant.location.address
        self.name = cellsRestaurant.name
        self.cuisines = cellsRestaurant.cuisines
        let imageURL = cellsRestaurant.imageURL ?? ""
        self.imageURL = imageURL.replacingOccurrences(of: "?output-format=webp", with: "")
        self.rating = cellsRestaurant.rating
        self.onlineDelivery = cellsRestaurant.onlineDelivery
        self.isFavorite = cellsRestaurant.favorite
    }
}
