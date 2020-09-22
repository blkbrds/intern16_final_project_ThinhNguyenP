//
//  HeaderDetailViewModel.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/16/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class HeaderDetailViewModel {
    var restaurant: Restaurant
    var viewModel: OverviewViewModel?

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    var cuisine: String {
        guard let cuisine = restaurant.cuisines else { return ""}
        return cuisine.replacingOccurrences(of: ",", with: " |")
    }
}
