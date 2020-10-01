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
     func syncFavorite(viewModel: FavoriteViewModel, needPerforms action: FavoriteViewModel.Action)
}

class FavoriteViewModel {

    enum Action {
        case reloadData
    }

    var restautants: [Restaurant] = []
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

    func fetchRealmData(completion: @escaping APICompletion) {
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
                    delegate.syncFavorite(viewModel: self, needPerforms: .reloadData)
                }
            })
        } catch {
            print(error.localizedDescription)
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

    func deleteItemFavorite(id: String, completion: @escaping APICompletion) {
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
}
