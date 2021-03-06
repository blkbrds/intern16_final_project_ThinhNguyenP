//
//  DetailOverViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

final class OverviewViewModel {

    var restaurant: Restaurant
    var isFavorite: Bool
    var hightlights: [String] {
        guard let highlights = restaurant.highlights else { return [] }
        return highlights
    }
    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
        isFavorite = restaurant.favorite
    }

    func getRestaurantDetail(completion: @escaping APICompletion) {
        let param = Api.Restaurant.RestaurantParam(id: restaurant.id ?? "" )
        Api.Restaurant.getRestaurantDetail(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let restaurant):
                this.restaurant = restaurant
                this.restaurant.favorite = this.isFavorite
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func addFavorite(completion: @escaping APICompletion) {
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

    func unfavorite(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(restaurant.id ?? "")'")
            try realm.write {
                realm.delete(result)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
