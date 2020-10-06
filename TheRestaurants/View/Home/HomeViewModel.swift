//
//  HomeViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

protocol HomeViewModelDelegate: class {

    func syncFavorite(viewModel: HomeViewModel, needPerform action: HomeViewModel.Action)
}

class HomeViewModel {

    enum Cell {
        case collectionView
        case tableView
    }

    enum Action {
        case reloadData
        case fail(Error)
    }

    var isLoadingMore: Bool = false
    var collections: [Collection] = []
    var restaurants: [Restaurant] = []
    var cells: [Cell] = [.collectionView, .tableView]
    var totalResults: Int = 0
    private var start: Int = 0
    var notificationToken: NotificationToken?
    weak var delegate: HomeViewModelDelegate?
    var canLoadMore: Bool {
        return start <= totalResults
    }

    deinit {
        notificationToken?.invalidate()
    }

    func loadCollection(completion: @escaping (APICompletion)) {
        let param = Api.ListCollection.ListCollectionParam()
        Api.ListCollection.getCollections(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let cells):
                this.collections = cells
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadCell(isLoadMore: Bool = false, completion: @escaping (APICompletion)) {
        if isLoadMore {
            start += 20
        } else {
            start = 0
        }
        let param = Api.ListCell.SearchParam(city: "city", start: start)
        Api.ListCell.getRestaurants(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let result):
                this.totalResults = result.totalResults
                if isLoadMore {
                    this.restaurants.append(contentsOf: result.restaurants)
                } else {
                    this.restaurants = result.restaurants
                }
                this.fetchRealmData(completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func numberOfSection() -> Int {
        return cells.count
    }

    func viewModelForListCollection(indexPath: IndexPath) -> ListCollectionsCellModel {
        let item = collections
        let viewModel = ListCollectionsCellModel(collections: item)
        return viewModel
    }

    func viewModelForHomeCell(indexPath: IndexPath) -> HomeCellModel {
        let item = restaurants[indexPath.row]
        let viewModel = HomeCellModel(restaurant: item)
        return viewModel
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard section < cells.count else { return 1 }
        switch cells[section] {
        case .collectionView:
            return 1
        case .tableView:
            return restaurants.count
        }
    }

    func didSelectRowAt(indexPath: IndexPath) -> DetailViewModel {
        let restaurant = restaurants[indexPath.row]
        let viewModel = DetailViewModel(restaurant: restaurant)
        return viewModel
    }

    func fetchRealmData(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = Array(realm.objects(Restaurant.self))
            for item in restaurants {
                if results.contains(where: { $0.id == item.id }) {
                    item.favorite = true
                }
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func addFavoriteItem(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let restaurant = restaurants[index]
            let tempRestaurant = Restaurant(id: restaurant.id,
                                            name: restaurant.name,
                                            imageURL: restaurant.imageURL,
                                            rating: restaurant.rating,
                                            onlineDelivery: restaurant.onlineDelivery,
                                            favorite: true,
                                            location: restaurant.location,
                                            establishment: restaurant.establishment,
                                            cuisines: restaurant.cuisines)
            try realm.write {
                realm.create(Restaurant.self, value: tempRestaurant, update: .all)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unfavoriteItem(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let restaurant = restaurants[index]
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
                    for item in this.restaurants {
                        if restaurants.contains(where: { $0.id == item.id }) {
                            item.favorite = true
                        } else {
                            item.favorite = false
                        }
                    }
                    this.delegate?.syncFavorite(viewModel: this, needPerform: .reloadData)
                case .error(let error):
                    this.delegate?.syncFavorite(viewModel: this, needPerform: .fail(error))
                default: break
                }
            })
        } catch {
            delegate?.syncFavorite(viewModel: self, needPerform: .fail(error))
        }
    }
}
