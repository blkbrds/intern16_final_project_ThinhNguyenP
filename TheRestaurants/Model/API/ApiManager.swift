//
//  ApiManager.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]
typealias Completion<Value> = (Result<Value>) -> Void

let api = ApiManager()

final class ApiManager {
    let session = Session()
    
    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["user-key"] =  "1a925bd3d2d1dedf236fe96cdb73fbe5"
        return headers
    }
}
