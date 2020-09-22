//
//  ReviewsViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class ReviewCellViewModel  {
    var reviews: [Review] = []
    var restaurant: Restaurant
    init(restaurant: Restaurant = Restaurant()) {
        self.restaurant = restaurant
    }

  func loadReview(completion: @escaping (APICompletion)) {
    let param = Api.Review.ReviewParam(id: restaurant.id ?? "")
         Api.Review.getReviews(param: param) { [weak self ](result) in
             guard let this = self else { return }
             switch result {
             case .success(let result):
                this.reviews = result.reviews
                 completion(.success)
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }

    func numberOfRowsInSection() -> Int {
        return reviews.count
    }

    func viewModelForCellAt(indexPath: IndexPath) -> ReviewCellModel {
        let review = reviews[indexPath.row]
        let viewModel = ReviewCellModel(review: review)
        return viewModel
    }
}
