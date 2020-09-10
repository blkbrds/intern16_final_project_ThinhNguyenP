//
//  SearchViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

enum Search {
    case resultSearch
    case historySearch
}

class SearchViewModel {
    var results: [Restaurant] = []
    var search: [Search] = [.resultSearch, .historySearch]
    var history: [SearchHistory] = []

    func numberOfRowInSectionResult() -> Int {
        return results.count
    }

    func numberOfRowInSectionHistoried() -> Int{
        return history.count
    }

    func getResult(keywork: String, completion: @escaping APICompletion) {
        let param = Api.Search.SearchParam(value: keywork)
        Api.Search.searchResult(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let results):
                this.results = results
                completion( .success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func viewModelForCellHistoried(at indexPath: IndexPath) -> HistorySearchCellModel {
        let item = history[indexPath.row]
        let viewModel = HistorySearchCellModel(searchHistory: item)
        return viewModel
    }

    func viewModelForCellResult(indexPath: IndexPath) -> SearchResultCellModel {
        let item = results[indexPath.row]
        let viewModel = SearchResultCellModel(restaurantData: item)
        return viewModel
    }
}
