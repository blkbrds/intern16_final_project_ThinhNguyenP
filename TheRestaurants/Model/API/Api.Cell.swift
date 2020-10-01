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

    struct APIResult {
        var totalResults: Int
        var restaurants: [Restaurant]
    }
    struct SearchParam {
        var city: String = ""
        var start: Int = 0
        func toJSON() -> [String: Any] {
            return [
                "entity_type": city,
                "entity_id": Session.cityId as Any,
                "start": start
            ]
        }
    }

    static func getRestaurants(param: SearchParam, completion: @escaping Completion<APIResult>) {
        let path = Api.Path.Search().urlStringListCell
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let value):
                    guard let value = value as? JSObject, let restaurants = value["restaurants"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var totalResults: Int = 0
                    if let resultsFound = value["results_found"] as? Int {
                        totalResults = resultsFound
                    }
                    var results: [Restaurant] = []
                    for item in restaurants {
                        guard let json = item["restaurant"] as? JSObject,
                        let restaurant = Mapper<Restaurant>().map(JSONObject: json) else { return }
                        results.append(restaurant)
                    }
                    let result = APIResult(totalResults: totalResults, restaurants: results)
                    completion(.success(result))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

//    static func searchRestaurants(param: SearchParam, completion: @escaping Completion<[Restaurant]>) {
//        let path = Api.Path.Search().urlStringListCell
//        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let value):
//                    guard let value = value as? JSObject, let restaurants = value["restaurants"] as? JSArray else {
//                        completion(.failure(Api.Error.json))
//                        return
//                    }
//                    var results: [Restaurant] = []
//                    for item in restaurants {
//                        guard let json = item["restaurant"] as? JSObject,
//                        let restaurant = Mapper<Restaurant>().map(JSONObject: json) else { return }
//                        results.append(restaurant)
//                    }
//                    completion(.success(results))
//                case .failure(let error ):
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
}
