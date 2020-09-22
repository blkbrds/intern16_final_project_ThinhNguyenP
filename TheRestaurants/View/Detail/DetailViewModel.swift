//
//  DetailViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class DetailViewModel {
    var id: String?

    init(id: String) {
        self.id = id
    }

//    func loadData(completion: @escaping APICompletion) {
////        let param = DetailViewModel(restaurant: restaurant).restaurant.id
////        let param = restaurant.id
//        let param = Api.Restaurant.RestaurantParam(id: self.restaurant.id)
////        let param = Api.Restaurant.RestaurantParam(id: self.restaurant.id!)
//        Api.Restaurant.detaiRestaurant(param: param) { [weak self ](result) in
//            guard let this = self else { return }
//            switch result {
//            case .success(let restaurant):
//                this.restaurant = restaurant
//                completion(.success)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
