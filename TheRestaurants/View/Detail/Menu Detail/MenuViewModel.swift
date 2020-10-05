//
//  MenuViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class MenuViewModel {

    var dailyMenus: [DailyMenu] = []
    var restaurant: Restaurant

    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
    }

    func getDailyMenuDetail(completion: @escaping APICompletion) {
        let param = Api.Search.ReviewParam(id: restaurant.id ?? "" )
        Api.Search.getMenu(param: param) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                this.dailyMenus = result
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

   func numberOfRowsInSection() -> Int {
        return dailyMenus.count
    }

    func viewModelForCellAt(indexPath: IndexPath) -> MenuCellModel {
        let dailyMenu = dailyMenus[indexPath.row]
        let viewModel = MenuCellModel(dailyMenu: dailyMenu)
        return viewModel
    }
}
