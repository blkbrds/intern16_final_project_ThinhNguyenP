//
//  DishMenu.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/29/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class DishMenu: Mappable {
    var dishName: String?
    var dishPrice: String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dishName <- map["name"]
        dishPrice <- map["price"]
    }
}
