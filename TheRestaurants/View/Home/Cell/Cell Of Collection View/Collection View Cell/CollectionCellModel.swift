//
//  HomeCollectionViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import UIKit

class CollectionCellModel {

    var numberOfRestaurant: Int = 12
    var imageUrl: String = ""
    var title: String = ""

    init(listCollection: CollecitonRestaurant) {
        self.numberOfRestaurant = listCollection.countPlaces
        self.title = listCollection.title
        self.imageUrl = listCollection.imageCollection
    }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCache.loadImage(urlString: imageUrl, completion: completion)
    }
}
