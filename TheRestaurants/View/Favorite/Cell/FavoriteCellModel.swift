//
//  FavoriteCellModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteCellModel {
    let restaurant: Restaurant
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
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
}
