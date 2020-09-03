//
//  PopUpViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class PopUpViewModel {

    enum LoadCitiesComplete {
        case success
        case failure(Error)
    }

    var dataCities: [City] = []
    var citiesSearch: [City] = []

    func numberOfRowInsection() -> Int {
        return dataCities.count
    }

    func viewModelForCell(at indexPath: IndexPath) -> PopUpTableViewModel {
        let item = dataCities[indexPath.row]
        let viewModel = PopUpTableViewModel(city: item)
        return viewModel
    }
}
