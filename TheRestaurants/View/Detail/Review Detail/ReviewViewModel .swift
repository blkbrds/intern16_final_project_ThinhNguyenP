//
//  ReviewsViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift

class ReviewViewModel {
    var reviews: [Review] = []
    var restaurant: Restaurant
    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
    }

  func loadReview(completion: @escaping (APICompletion)) {
    let param = Api.Search.ReviewParam(id: restaurant.id ?? "")
         Api.Search.getReviews(param: param) { [weak self ](result) in
             guard let this = self else { return }
             switch result {
             case .success(let result):
                this.reviews = result
                completion(.success)
             case .failure(let error):
                completion(.failure(error))
             }
         }
     }

    func numberOfRowsInSection() -> Int {
        return reviews.count
    }

    func viewModelForCellAt(indexPath: IndexPath) -> ReviewCellViewModel {
        let review = reviews[indexPath.row]
        let viewModel = ReviewCellViewModel(review: review)
        return viewModel
    }
    
    func unFavorite(id: String, completion: @escaping APICompletion) {
        do {
            let realm = try Realm()
            let result = realm.objects(Restaurant.self).filter("id = '\(id)'")
            try realm.write {
                realm.delete(result)
                checkFavorite(favorite: false, id: id)
            }
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }

    func checkFavorite(favorite: Bool, id: String) {
        if restaurant.id == id {
            restaurant.favorite = favorite
        }
    }
}
