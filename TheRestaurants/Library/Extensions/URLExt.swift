//
//  URLExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation

extension URL {
    public var imageRequest: NSMutableURLRequest {
        let request = NSMutableURLRequest(url: self)
        request.addValue("image/*", forHTTPHeaderField: "Accept")
        return request
    }
}
