//
//  DetailViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

protocol DetailViewModelDelegate: class {
     func syncFavorite(viewModel: DetailViewModel, needperformAction action: DetailViewModel.Action)
}
class DetailViewModel {
    
    enum Action {
        case reloadData
    }
    var restaurant: Restaurant
    var notificationToken: NotificationToken?
    weak var delegate: DetailViewModelDelegate?
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    func checkFavorite(favorite: Bool, id: String) {
        if restaurant.id == id {
            restaurant.favorite = favorite
        }
    }

    func addFavorite(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
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
//                checkFavorite(favorite: true, id: tempRestaurant.id ?? "")
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unFavorite(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(restaurant.id ?? "")'")
            try realm.write {
                realm.delete(result)
                checkFavorite(favorite: false, id: restaurant.id ?? "")
            }
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
}
