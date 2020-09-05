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
        var value: Int?
        func toJSON() -> [String: Any] {
            return [
                "city_id": value 
            ]
        }
    }

    static func loadCollection(completion: @escaping Completion<[Collection]>) -> Request? {
        let path = Api.Path.ListCollection().urlString
        return api.request(method: .get, urlString: path) { (result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let value):
                    guard let value = value as? JSObject, let collections = value["collections"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [Collection] = []
                    for collection in collections {
                        guard let key = collection["collection"] as? JSObject,
                            let key2 = Mapper<Collection>().map(JSONObject: key) else { return }
                        results.append(key2)
                    }
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
