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

//    private func setupObserve() {
//        do {
//            let realm = try Realm()
//            notificationToken = realm.objects(FavoriteHistory.self).observe({ (_) in
//                if let delegate = self.delegate {
//                    delegate.syncFavorite(viewModel: self, needperformAction: .reloadData)
//                }
//            })
//        } catch {
//            print(error)
//        }
//    }
    
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


}
