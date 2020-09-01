//
//  Api.Collection.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.ListCollection {
    struct ListCollectionParam {
        var value: Int = 12
        var key: String = "city_id"
        
        func toJSON() -> [String: Any] {
            return [
                "city_id": value 
            ]
        }
    }

    static func loadCollection(completion: @escaping Completion<[CollecitonRestaurant]>) -> Request? {
        let path = Api.Path.ListCollection().urlString
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let value):
                    guard let value = value as? JSObject, let json = value["collections"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let collections = Mapper<CollecitonRestaurant>().mapArray(JSONArray: json)
                    completion(.success(collections))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
