//
//  Api.Review.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/17/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Review {
    struct APIResult {
        var totalRatings: Int
        var totalReviews: Int
        var reviews: [Review]
    }
    struct ReviewParam {
        var id: String
        func toJSON() -> [String: Any] {
            return [
                "res_id": id
            ]
        }
    }

    static func getReviews(param: ReviewParam, completion: @escaping Completion<APIResult>) {
        let path = Api.Path.Search().urlStringReview
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let userReview = value["user_reviews"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var totalRatings: Int = 0
                    var totalReviews: Int = 0
                    if let resultRatings = value["reviews_shown"] as? Int, let resultReviews = value["reviews_count"] as? Int {
                        totalRatings = resultRatings
                        totalReviews = resultReviews
                    }
                    var results: [Review] = []
                    for review in userReview {
                        guard let json = review["review"] as? JSObject, let review = Mapper<Review>().map(JSONObject: json) else { return }
                        results.append(review)
                    }
                     let result = APIResult(totalRatings: totalRatings, totalReviews: totalReviews, reviews: results)
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
