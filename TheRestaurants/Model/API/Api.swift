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
    struct ListCell { }

}

extension Api.Path {
    struct Search: ApiPath {
        static var path: String { return baseURL }

        var urlString: String {
            return Search.path / "cities"
        }

        var urlStringListCell: String {
            return Search.path / "search"
        }

        var urlStringListCollection: String {
            return Search.path / "collections"
        }

        var urlStringReview: String {
            return Search.path / "reviews"
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
