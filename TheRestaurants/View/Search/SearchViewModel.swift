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
    var history: [SearchHistory] = []
     private var notificationToken: NotificationToken?
    
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
    
    func viewModelForCellResult(indexPath: IndexPath) -> HomeCellModel {
        let item = results[indexPath.row]
        let viewModel = HomeCellModel(cellsRestaurant: item)
        return viewModel
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard section < search.count else { return 1 }
        switch search[section] {
        case .historySearch:
            return history.count
        case .resultSearch:
            return results.count
        }
    }
    
    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(SearchHistory.self).observe({ [weak self ](_) in
                guard let this = self else { return }
                this.fetchRealmData()
                for i in 0..<this.results.count {
                    this.results[i].
                }
            })
            
            
        }
    }
    
    func fetchRealmData() {
        do {
            let realm = try Realm()
            let results = realm.objects(SearchHistory.self)
            history = Array(results)
        } catch {
            print(error)
        }
    }
}
