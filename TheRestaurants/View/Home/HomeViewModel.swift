//
//  HomeViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

class HomeViewModel {
    
    enum Cell {
        case collectionView
        case tableView
    }

    enum Action {
        case reloadData
    }

    var isLoadingMore: Bool = false
    var collections: [Collection] = []
    var restaurants: [Restaurant] = []
    var cells: [Cell] = [.collectionView, .tableView]
    var totalResults: Int = 0
    private var start: Int = 0
    var notificationToken: NotificationToken?
    var canLoadMore: Bool {
        return start <= totalResults
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

    func checkFavorite(favorite: Bool, id: String) {
        for item in restaurants where item.id == id {
            item.favorite = favorite
        }
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

    func addFavorite(index: Int, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let restaurant = restaurants[index]
            let tempRestaurant = Restaurant(id: restaurant.id,
                                            name: restaurant.name,
                                            imageURL: restaurant.imageURL,
                                            rating: restaurant.rating,
                                            onlineDelivery: restaurant.onlineDelivery,
                                            favorite: restaurant.favorite,
                                            location: restaurant.location,
                                            establishment: restaurant.establishment)
            try realm.write {
                realm.create(Restaurant.self, value: tempRestaurant, update: .all)
                checkFavorite(favorite: true, id: tempRestaurant.id ?? "")
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unFavorite(index: Int, completion: @escaping APICompletion) {
       do {
            let realm = try Realm()
            let restaurant = restaurants[index]
            let result = realm.objects(Restaurant.self)
            try realm.write {
                realm.delete(result)
            }
        completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func setupObserve() {
//        do {
//            let realm = try Realm()
//            notificationToken = realm.objects(Restaurant.self).observe({ [weak self ](_) in
//                guard let this = self, let delegate = this.delegate else { return }
//                this.fetchRealmData()
//                for index in 0..<this.restaurants.count {
//                    this.restaurants[index].favorite = this.realmRestaurant.contains(where: { $0.id == this.restaurants[index].id })
//                }
//                delegate.syncFavorite(this, needperformAction: .reloadData)
//            })
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}
