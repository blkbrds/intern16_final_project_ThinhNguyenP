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
    var resultShow: Int?

    init(cellsRestaurant: Restaurant ) {
        self.address = cellsRestaurant.address
        self.name = cellsRestaurant.name
        self.cuisines = cellsRestaurant.cuisines
        self.imageURL = cellsRestaurant.imageURL
        self.rating = cellsRestaurant.rating
        self.onlineDelivery = cellsRestaurant.onlineDelivery
        self.isFavorite = cellsRestaurant.favorite
    }

   func loadImage(completion: @escaping (UIImage?) -> Void) {
    ImageCache.loadImage(urlString: imageURL ?? "ic-home-no-image-1", completion: completion)
    }
}
