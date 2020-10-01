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
        func toJSON() -> [String: Any] {
            return [
                "city_id": Session.cityId as Any
            ]
        }
    }

    static func getCollections(param: ListCollectionParam, completion: @escaping Completion <[Collection]>) {
        let path = Api.Path.Search().urlStringListCollection
        api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject, let collections = value["collections"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    var results: [Collection] = []
                    for collection in collections {
                        guard let json = collection["collection"] as? JSObject,
                            let result = Mapper<Collection>().map(JSONObject: json) else { return }
                        results.append(result)
                    }
                    completion(.success(results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
