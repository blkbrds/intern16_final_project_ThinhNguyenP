//
//  DetailOverViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class OverviewViewModel {

    var id: String = ""
    var viewModel: DetailViewModel?
    
    init(id: String = "") {
        self.id = id
    }
    
    func loadData(completion: @escaping APICompletion) {
//        guard let viewModel = viewModel else { return }
        let param = Api.Restaurant.RestaurantParam(id: id )
        Api.Restaurant.detaiRestaurant(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let restaurant):
                print(restaurant.address)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
