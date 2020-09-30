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

    func feachRealm(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = realm.objects(Restaurant.self)
            restautants = Array(results)
            completion(.success)
        } catch {
            completion(.failure(error))
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

    func deleteAllItem(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = realm.objects(Restaurant.self)
            try realm.write {
                realm.delete(results)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func deleteItemFavorite(id: String) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(result)
            }
        } catch {
           print("Error")
        }
    }

//    func deleteItemFavorite(id: String) {
//        do {
//            let realm = try Realm()
//            let result = realm.objects(Restaurant.self).filter("id = '\(id)'")
//            try realm.write {
//                realm.delete(result)
//                checkFavorite(favorite: false, id: id)
//            }
//        } catch {
//            print(error)
//        }
//    }

    func checkFavorite(favorite: Bool, id: String) {
        for item in restautants where item.id == id {
            item.favorite = favorite
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
