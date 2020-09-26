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
    var isLoadingMore: Bool = false
    var realmRestaurant: [Restaurant] = []
    var collections: [Collection] = []
    var restaurants: [Restaurant] = []
    var cells: [Cell] = [.collectionView, .tableView]
    var totalResults: Int = 0
    private var start: Int = 0
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
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func numberOfSection() -> Int {
        return cells.count
    }
    
    func viewModelForCell(indexPath: IndexPath) -> ListCollectionsCellModel {
        let item = collections
        let viewModel = ListCollectionsCellModel(collections: item)
        return viewModel
    }
    
    func viewModelForCell2(indexPath: IndexPath) -> HomeCellModel {
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
    
    func deleteItemFavorite(name: String) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("name = '\(name)'")
            try realm.write {
                realm.delete(result)
                checkFavorite(favorite: false, name: name)
            }
        } catch {
            print(error)
        }
    }
    func checkFavorite(favorite: Bool, name: String) {
        for item in realmRestaurant where item.name == name {
            item.favorite = favorite
        }
    }
    func addFavorite(name: String, onlineDelivery: Int, imageURL: String, address: String) {
        do {
            let realm = try Realm()
            let restaurant = Restaurant()
            restaurant.name = name
            restaurant.location.address = address
            restaurant.onlineDelivery = onlineDelivery
            restaurant.imageURL = imageURL
            try realm.write {
                realm.add(restaurant, update: .all)
                checkFavorite(favorite: true, name: name )
            }
        } catch {
            print(error)
        }
    }
}
