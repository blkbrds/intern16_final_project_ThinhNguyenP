//
//  InformationDetailViewModel.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/23/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class InformationDetailViewModel {
    var restaurant: Restaurant

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    var openingTime: String {
        guard let timing = restaurant.timings else { return "" }
        return timing.replacingOccurrences(of: ",", with: "\n")
    }
}
