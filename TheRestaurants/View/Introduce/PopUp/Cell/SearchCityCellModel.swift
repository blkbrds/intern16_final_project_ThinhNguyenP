//
//  PopUpTableViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import UIKit

class SearchCityCellModel {

    var city: City

    init(city: City) {
        self.city = city
    }

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCache.loadImage(urlString: city.flagUrl, completion: completion)
    }
}
