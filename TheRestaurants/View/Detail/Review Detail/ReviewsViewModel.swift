//
//  ReviewsViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class ReviewsViewModel {
    var reviews: [Review] = []
    var reviewsCount: Int = 0
    var ratingCount: Int = 0
    var id: String = ""
    init(id: String = "") {
        self.id = id
    }

  func loadReview(completion: @escaping (APICompletion)) {
    let param = Api.Review.ReviewParam(id: id)
         Api.Review.getReviews(param: param) { [weak self ](result) in
             guard let this = self else { return }
             switch result {
             case .success(let cells):
                this.reviewsCount = cells.totalReviews
                this.ratingCount = cells.totalRatings
                this.reviews = cells.reviews
                 completion(.success)
             case .failure(let error):
                 completion(.failure(error))
             }
         }
     }

    func numberOfRowsInSection() -> Int {
        return reviews.count
    }

    func cellForRowAt(indexPath: IndexPath) -> ReviewCellModel {
        let index = reviews[indexPath.row]
        let viewModel = ReviewCellModel(review: index)
        return viewModel
    }
}
