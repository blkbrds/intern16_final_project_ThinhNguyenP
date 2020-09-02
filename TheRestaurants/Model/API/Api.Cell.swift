//
//  Api.Cell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/1/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.ListCell {

    static func loadCell(completion: @escaping Completion<[CellRestaurant]>) -> Request? {
        let path = Api.Path.ListCell().urlString
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let value):
                    guard let value = value as? JSObject, let restaurants = value["restaurants"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [CellRestaurant] = []
                    for item in restaurants {
                        guard let restaurant = item["restautant"] as? JSObject, let location = restaurant["location"] as? JSObject,
                        let restaurant2 = Mapper<CellRestaurant>().map(JSONObject: location) else { return }
                        results.append(restaurant2)
                    }
                    completion(.success(results))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
