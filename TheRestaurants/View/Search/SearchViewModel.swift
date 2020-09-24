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
    var search: [Search] = [.resultSearch, .historySearch]
    var histories: [SearchHistory] = []
    private var notificationToken: NotificationToken?

    func numberOfRowInSectionResult() -> Int {
        return results.count
    }

    func numberOfRowInSectionHistoried() -> Int {
        return histories.count
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
        let item = histories[indexPath.row]
        let viewModel = HistorySearchCellModel(searchHistory: item)
        return viewModel
    }

    func viewModelForCellResult(indexPath: IndexPath) -> HomeCellModel {
        let item = results[indexPath.row]
        let viewModel = HomeCellModel(cellsRestaurant: item)
        return viewModel
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard section < search.count else { return 1 }
        switch search[section] {
        case .historySearch:
            return histories.count
        case .resultSearch:
            return results.count
        }
    }

    func fetchData(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = realm.objects(SearchHistory.self)
//            histories = Array(results)
            results.reversed()
            histories = Array(results.prefix(5))
//            histories.reverse()
            print("DEBUG - Histories", histories.map({ $0.searchKey }))
        } catch {
            print(error)
        }
    }

    func addRealm(searchKey: String, completion: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            let result = SearchHistory()
            result.searchKey = searchKey
            try realm.write {
                realm.add(result)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }
    func didSelectRowAt(indexPath: IndexPath) -> DetailViewModel {
        let item = results[indexPath.row]
        let viewModel = DetailViewModel(restaurant: item)
        return viewModel
    }
}
