//
//  PopUpViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class SearchCityPopUpViewModel {

    var dataCities: [City] = []
    var dataRestaurant: [Restaurant] = []

    func numberOfRowInsection() -> Int {
        return dataCities.count
    }

    func searchCities(value: String, completion: @escaping APICompletion) {
        let param = Api.Search.SearchParam(value: value)
        Api.Search.search(param: param) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let cities):
                this.dataCities = cities
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> SearchCityCellModel {
        let item = dataCities[indexPath.row]
        let viewModel = SearchCityCellModel(city: item)
        return viewModel
    }

    func didSelectRowAt(index: Int) {
        let item = dataCities[index]
        Session.cityId = item.id
    }
}
