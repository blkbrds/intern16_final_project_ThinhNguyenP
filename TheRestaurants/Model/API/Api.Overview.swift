//
//  Api.OverView.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/23/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Restaurant {
    struct RestaurantParam {
        var id: String
        func toJSON() -> [String: Any] {
            return [
                "res_id": id
            ]
        }
    }

    static func detaiRestaurant(param: RestaurantParam, completion: @escaping Completion <Restaurant>) {
        let path = Api.Path.Search().urlStringRestaurant
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: Restaurant
                    guard let valueData = Mapper<Restaurant>().map(JSONObject: value) else { return }
                    results = valueData
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
