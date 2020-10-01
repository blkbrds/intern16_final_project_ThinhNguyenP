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
                this.fetchRealmData(completion: completion)
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
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func fetchRealmData(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let results = Array(realm.objects(Restaurant.self))
                if results.contains(where: { $0.id == restaurant.id }) {
                    restaurant.favorite = true
                }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
