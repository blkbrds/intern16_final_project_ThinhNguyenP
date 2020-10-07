//
//  User.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/25/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

final class User: Mappable {

    required convenience init?(map: Map) {
        self.init()
    }

    var name: String?
    var imageUrl: String?

    func mapping(map: Map) {
        name <- map["name"]
        imageUrl <- map["profile_image"]
    }
}
