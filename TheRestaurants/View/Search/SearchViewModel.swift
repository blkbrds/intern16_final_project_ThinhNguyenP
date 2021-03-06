//
//  SearchViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

protocol SearchViewModelDelegate: class {

    func syncFavorite(viewModel: SearchViewModel, needPerforms action: SearchViewModel.Action)
}
enum Search {
    case result
    case history
}

final class SearchViewModel {

    enum Action {
        case reloadData
        case fail(Error)
    }

    var results: [Restaurant] = []
    var histories: [SearchHistory] = []
    var notificationToken: NotificationToken?
    weak var delegate: SearchViewModelDelegate?

    deinit {
        notificationToken?.invalidate()
    }

    func numberOfRowInSectionResult() -> Int {
        return results.count
    }

    func numberOfRowInSectionHistoried() -> Int {
        return histories.count
    }

    func getResult(keywork: String, completion: @escaping APICompletion) {
        let param = Api.Search.SearchRestaurant(entityType: "city", q: keywork)
        Api.Search.searchRestaurants(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let results):
                this.results = results
                this.fetchRealmData(completion: completion)
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

    func fetchRealmData(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let resultsRealm = Array(realm.objects(Restaurant.self))
            for item in results {
                if resultsRealm.contains(where: { $0.id == item.id }) {
                    item.favorite = true
                }
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func addFavorite(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let restaurant = results[index]
            try realm.write {
                restaurant.favorite = true
                realm.create(Restaurant.self, value: restaurant, update: .all)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unFavorite(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let restaurant = results[index]
            let result = realm.objects(Restaurant.self).filter("id = '\(restaurant.id ?? "")'")
            try realm.write {
                realm.delete(result)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func setupObserver() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Restaurant.self).observe({ [weak self] changes in
                guard let this = self else { return }
                switch changes {
                case .update(let restaurants, _, _, _):
                    for item in this.results {
                        if restaurants.contains(where: { $0.id == item.id }) {
                            item.favorite = true
                        } else {
                            item.favorite = false
                        }
                    }
                    this.delegate?.syncFavorite(viewModel: this, needPerforms: .reloadData)
                case .error(let error):
                    this.delegate?.syncFavorite(viewModel: this, needPerforms: .fail(error))
                default: break
                }
            })
        } catch {
            delegate?.syncFavorite(viewModel: self, needPerforms: .fail(error))
        }
    }
}
