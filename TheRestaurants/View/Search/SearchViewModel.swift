//
//  SearchViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

enum Search {
    case resultSearch
    case historySearch
}

class SearchViewModel {
    var results: [Restaurant] = []
    var histories: [SearchHistory] = []

    func numberOfRowInSectionResult() -> Int {
        return results.count
    }

    func numberOfRowInSectionHistoried() -> Int {
        return histories.count
    }

    func getResult(keywork: String, completion: @escaping APICompletion) {
        let param = Api.Search.SearchParam(value: keywork)
        Api.Search.searchRestaurants(param: param) { [weak self ](result) in
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

    func viewModelForHistoryCell(at indexPath: IndexPath) -> HistorySearchCellModel {
        let item = histories[indexPath.row]
        let viewModel = HistorySearchCellModel(searchHistory: item)
        return viewModel
    }

    func viewModelForResultCell(indexPath: IndexPath) -> HomeCellModel {
        let item = results[indexPath.row]
        let viewModel = HomeCellModel(restaurant: item)
        return viewModel
    }

    func fetchSearchHistoryData(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = realm.objects(SearchHistory.self)
            histories = Array((results).reversed())
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func saveKeyToRealm(searchKey: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = SearchHistory()
            result.searchKey = searchKey
            try realm.write {
                realm.add(result)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func didSelectRowAt(indexPath: IndexPath) -> DetailViewModel {
        let item = results[indexPath.row]
        let viewModel = DetailViewModel(restaurant: item)
        return viewModel
    }
}
