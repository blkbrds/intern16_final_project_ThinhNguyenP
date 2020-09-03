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
}
