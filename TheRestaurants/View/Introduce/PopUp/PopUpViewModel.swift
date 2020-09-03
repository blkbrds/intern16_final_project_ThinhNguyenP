//
//  PopUpViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class PopUpViewModel {

    var dataCities: [City] = []
    var citiesSearch: [City] = []

    func numberOfRowInsection() -> Int {
        return dataCities.count
    }

    func viewModelForCell(at indexPath: IndexPath) -> SearchCityCellModel {
        let item = dataCities[indexPath.row]
        let viewModel = SearchCityCellModel(city: item)
        return viewModel
    }
}
