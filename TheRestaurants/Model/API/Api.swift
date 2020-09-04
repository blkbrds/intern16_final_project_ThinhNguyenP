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
        static let baseURL = "https://developers.zomato.com/api/v2.1"
    }
    struct ListCollection {
    }
    struct ListCell {
    }
}

extension Api.Path {
    struct ListCollection: ApiPath {
        static var path: String { return baseURL / "collections?city_id=10" }
        var urlString: String {
            return ListCollection.path
        }
    }
    struct ListCell: ApiPath {
        static var path: String { return baseURL / "search?entity_type=city&entity_id=12&start=20" }
        var urlString: String {
        return ListCell.path
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
