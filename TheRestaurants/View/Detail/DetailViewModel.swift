//
//  DetailViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

class DetailViewModel {

    enum Action {
        case reloadData
    }
    var usedRestaurant: Restaurant
    var restaurant: Restaurant
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.usedRestaurant = Restaurant(id: restaurant.id,
                                         name: restaurant.name,
                                         imageURL: restaurant.imageURL,
                                         rating: restaurant.rating,
                                         onlineDelivery: restaurant.onlineDelivery,
                                         favorite: restaurant.favorite,
                                         location: restaurant.location,
                                         establishment: restaurant.establishment,
                                         cuisines: restaurant.cuisines,
                                         review: restaurant.review)
    }

    func addFavoriteItem(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let tempRestaurant = Restaurant(id: usedRestaurant.id,
                                            name: usedRestaurant.name,
                                            imageURL: usedRestaurant.imageURL,
                                            rating: usedRestaurant.rating,
                                            onlineDelivery: usedRestaurant.onlineDelivery,
                                            favorite: true,
                                            location: usedRestaurant.location,
                                            establishment: usedRestaurant.establishment,
                                            cuisines: restaurant.cuisines,
                                            review: restaurant.review)
            try realm.write {
                realm.create(Restaurant.self, value: tempRestaurant, update: .all)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func unfavoriteItem(completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(restaurant.id ?? "")'")
            try realm.write {
                realm.delete(result)
                restaurant = Restaurant(id: usedRestaurant.id,
                                        name: usedRestaurant.name,
                                        imageURL: usedRestaurant.imageURL,
                                        rating: usedRestaurant.rating,
                                        onlineDelivery: usedRestaurant.onlineDelivery,
                                        favorite: true,
                                        location: usedRestaurant.location,
                                        establishment: usedRestaurant.establishment,
                                        cuisines: restaurant.cuisines,
                                        review: restaurant.review)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
