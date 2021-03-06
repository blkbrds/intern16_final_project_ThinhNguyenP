//
//  Api.Search.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/3/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Search {

    struct SearchParam {
        var value: String = ""
        func toJSON() -> [String: Any ] {
            return [
                "q": value
            ]
        }
    }
    struct SearchRestaurant {
        var entityType: String = ""
        var q: String = ""
        func toJSON() -> [String: Any] {
            return [
                "q": q,
                "entity_id": Session.cityId as Any,
                "entity_type": entityType
            ]
        }
    }

    static func search(param: SearchParam, completion: @escaping Completion<[City]>) {
        let path = Api.Path.Search().urlString
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result ) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let json = value["location_suggestions"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let cities = Mapper<City>().mapArray(JSONArray: json)
                    completion(.success(cities))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    static func searchRestaurants(param: SearchRestaurant, completion: @escaping Completion<[Restaurant]>) {
        let path = Api.Path.Search().urlStringListCell
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let restaurants = value["restaurants"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [Restaurant] = []
                    for item in restaurants {
                        guard let json = item["restaurant"] as? JSObject,
                        let restaurant = Mapper<Restaurant>().map(JSONObject: json) else { return }
                        results.append(restaurant)
                    }
                    completion(.success(results))
                case .failure(let error ):
                    completion(.failure(error))
                }
            }
        }
    }
}
