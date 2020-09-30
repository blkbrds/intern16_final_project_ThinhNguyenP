//
//  DetailOverViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

class OverviewViewModel {
    var restaurant: Restaurant
    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
    }

    func getRestaurantDetail(completion: @escaping APICompletion) {
        let param = Api.Restaurant.RestaurantParam(id: restaurant.id ?? "" )
        Api.Restaurant.getRestaurantDetail(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let restaurant):
                this.restaurant = restaurant
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addFavorite(id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let tempRestaurant = Restaurant(value: restaurant.id ?? "")
            try realm.write {
                realm.create(Restaurant.self, value: tempRestaurant, update: .all)
//                checkFavorite(favorite: true, id: tempRestaurant.id ?? "")
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unFavorite(id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(result)
//                checkFavorite(favorite: false, id: id)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
