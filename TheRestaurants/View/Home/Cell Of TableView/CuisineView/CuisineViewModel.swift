//
//  CuisineViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

final class CuisineViewModel {

    var cuisine: String
    var isTitle: Bool

    init(cuisine: String, isTitle: Bool = false) {
        self.cuisine = cuisine
        self.isTitle = isTitle
    }
}
