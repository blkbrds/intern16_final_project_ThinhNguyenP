//
//  Api.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation
import Alamofire

final class Api {

    struct Path {
        static var  baseURL = "https://developers.zomato.com/api/v2.1"
    }

    struct ListCollection { }
    struct Search { }
    struct SearchResult { }
}

extension Api.Path {
    struct Search: ApiPath {
        static var path: String { return baseURL }

        var urlString: String {
            return Search.path / "cities"
        }

        static var path2: String { return baseURL }
        var urlString2: String {
            return Search.path / "search?entity_type=&entity_id&"
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending("\(right)")
}
