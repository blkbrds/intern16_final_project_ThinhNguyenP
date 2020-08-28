//
//  Api.Search.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/27/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Search {

    struct SearchParam {
        var value: String = ""
        var key: String = "q"

        func toJSON() -> [String: Any ] {
            return [
                "q": value
            ]
        }
    }

    static func search(param: SearchParam, completion: @escaping Completion<[City]>) -> Request? {
        let path = Api.Path.Search().urlString
        print(path)
        return api.request(method: .get, urlString: path, parameters: param.toJSON()) { (result) in
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
}
