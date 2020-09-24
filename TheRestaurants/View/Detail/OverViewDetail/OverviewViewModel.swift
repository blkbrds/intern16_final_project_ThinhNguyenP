//
//  DetailOverViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class OverviewViewModel {
    var restaurant: Restaurant
    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
    }

    func loadData(completion: @escaping APICompletion) {
        let param = Api.Restaurant.RestaurantParam(id: restaurant.id ?? "" )
        Api.Restaurant.getRestaurantDetail(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let restaurant):
                this.restaurant = restaurant
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
