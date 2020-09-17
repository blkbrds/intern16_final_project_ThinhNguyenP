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
    struct ReviewParam {
        func toJSON() -> [String: Any] {
            return [
                "res_id": 1777
            ]
        }
    }
    static func getReviews(param: ReviewParam, completion: @escaping Completion<([Review], Int, Int)>) {
        let path = Api.Path.Search().urlStringReview
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let reviewCount = value["reviews_count"] as? Int, let userReview = value["user_reviews"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [Review] = []
                    for review in userReview {
                        guard let json = review["review"] as? JSObject, let result = Mapper<Review>().map(JSONObject: json) else { return }
                        results.append(result)
                    }
                    completion(.success((results, reviewCount)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
