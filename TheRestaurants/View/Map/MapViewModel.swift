//
//  MapViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/9/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class MapViewModel {
    var restaurantData: [Restaurant] = []

    func numberOfRowInSection() -> Int {
        return restaurantData.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CurrentCollectionCellModel{
        let item = restaurantData[indexPath.row]
        let viewModel = CurrentCollectionCellModel(restaurantData: item)
        return viewModel
    }
}
