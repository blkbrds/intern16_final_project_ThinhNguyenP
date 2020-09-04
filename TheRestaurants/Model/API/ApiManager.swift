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
typealias APICompletion = (APIResult) -> Void

enum APIResult {
    case success
    case failure(Error)
}

let api = ApiManager()

final class ApiManager {

    let session = Session()

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["user-key"] = App.Key.userKey
        return headers
    }
}
