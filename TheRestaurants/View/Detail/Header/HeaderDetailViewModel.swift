//
//  HeaderDetailViewModel.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/23/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class HeaderDetailViewModel {
    var restaurant: Restaurant
    var isFavorite = true
    var cuisine: String
    init(restaurant: Restaurant, cuisine: String = "") {
        self.restaurant = restaurant
        self.restaurant.id = restaurant.id
        isFavorite = restaurant.favorite
//        self.restaurant.favorite = restaurant.favorite
        self.cuisine = cuisine.replacingOccurrences(of: ",", with: " |")
    }
}
