//
//  Api.Overview.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/16/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Restaurant {
    struct RestaurantParam {
        func toJSON() -> [String: Any] {
            return [
                "res_id": 16774318
            ]
        }
    }
    static func detaiRestaurant(param: RestaurantParam, completion: @escaping Completion <Restaurant>) {
        let path = Api.Path.Search().urlStringRestaurant
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let location = value["location"] as? JSObject else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: Restaurant
                    guard let json = location["location"] as?  JSObject, let valueData = Mapper<Restaurant>().map(JSONObject: json) else { return }
                    results = valueData
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
