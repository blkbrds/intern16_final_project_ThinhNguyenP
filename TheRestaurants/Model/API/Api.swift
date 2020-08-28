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
       // static let pathURL = "https://developers.zomato.com/api/v2.1/"
//        static let apiListCities = "\(baseURL)cities?q=keysearch"
    }

    struct Search {
//        let key: String
    }
}

extension Api.Path {
    
    struct Search: ApiPath {
        static var path: String { return baseURL / "cities?q="}
        var urlString: String {
            return Search.path
        }
    }
    
//    struct Search {
//        static let path: String = baseURL / "cities?q="
//        let key: String
//        var url: String { Search.path + key }
//    }
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
