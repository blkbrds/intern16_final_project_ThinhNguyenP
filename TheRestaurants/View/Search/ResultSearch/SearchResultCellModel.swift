//
//  SearchResultCellModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/3/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCellModel {
    var restaurant: Restaurant
    init(restaurantData: Restaurant) {
        self.restaurant = restaurantData
    }
    
    func loadImage(compeltion: @escaping (UIImage?) -> Void) {
        ImageCache.loadImage(urlString: restaurant.imageURL ?? "", completion: compeltion)
    }
}
