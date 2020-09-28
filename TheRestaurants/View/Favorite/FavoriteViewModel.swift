//
//  FavoriteViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteViewModelDelegate: class {
    func syncFavorite(viewModel: FavoriteViewModel, needperformAction action: FavoriteViewModel.Action)
}

class FavoriteViewModel {
    enum Action {
        case reloadData
    }
    
    var restautants: [Restaurant] = []
    //    var favorite: [FavoriteHistory] = []
    var isFavorite: Bool = false
    private var notificationToken: NotificationToken?
    weak var delegate: FavoriteViewModelDelegate?
    
    func numberOfRowInSection() -> Int {
        return restautants.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> FavoriteCellModel {
        let item = restautants[indexPath.row]
        let viewModel = FavoriteCellModel(restaurant: item)
        return viewModel
    }
    
    //    func getData(completion: @escaping (Bool) -> ()) {
    //        do {
    //            restautants.removeAll()
    //            let realm = try Realm()
    //            let restaurant = realm.objects(Restaurant.self)
    //            for item in restaurant {
    //                let restaurant = Restaurant()
    //                restaurant.name = item.name
    //                restaurant.imageURL = item.imageURL
    //                restaurant.onlineDelivery = item.onlineDelivery
    //                restaurant.rating = item.rating
    //                restaurant.location?.address = item.location?.address
    //                restaurant.app
    //            }
    //            completion(true)
    //        } catch {
    //            completion(false)
    //        }
    //    }
    
    func feachRealm() {
        do {
            let realm = try Realm()
            let results = realm.objects(Restaurant.self)
            restautants = Array(results)
        } catch {
            print("error")
        }
    }

    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Restaurant.self).observe({ (_) in
                if let delegate = self.delegate {
                    delegate.syncFavorite(viewModel: self, needperformAction: .reloadData)
                }
            })
        } catch {
            print(error)
        }
    }
    
    //    func fetchSearchHistoryData(completion: @escaping APICompletion) {
    //        do {
    //            let realm = try Realm()
    //            let results = realm.objects(FavoriteHistory.self)
    //            favorite = Array((results).reversed())
    //            completion(.success)
    //        } catch {
    //            completion(.failure(error))
    //        }
    //    }
    //    func addFavorite(name: String, onlineDelivery: Int, imageURL: String, address: String) {
    //        do {
    //            let realm = try Realm()
    //            let restaurant = Restaurant()
    //            restaurant.name = name
    //            restaurant.location.address = address
    //            restaurant.onlineDelivery = onlineDelivery
    //            restaurant.imageURL = imageURL
    //            try realm.write {
    //                realm.add(restaurant, update: .all)
    //                checkFavorite(favorite: true, name: name )
    //            }
    //        } catch {
    //            print(error)
    //        }
    //    }
}
