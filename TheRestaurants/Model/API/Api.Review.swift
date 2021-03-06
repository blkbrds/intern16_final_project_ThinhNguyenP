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

extension Api.Search {
    struct ReviewParam {
        var id: String
        func toJSON() -> [String: Any] {
            return [
                "res_id": id
            ]
        }
    }

    static func getReviews(param: ReviewParam, completion: @escaping Completion<[Review]>) {
        let path = Api.Path.Search().urlStringReview
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let userReview = value["user_reviews"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [Review] = []
                    for review in userReview {
                        guard let json = review["review"] as? JSObject,
                            let review = Mapper<Review>().map(JSONObject: json) else { return }
                        results.append(review)
                    }
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
