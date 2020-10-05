//
//  DailyMenu.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/29/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class DailyMenu: Mappable {

    var startDate: String?
    var endDate: String?
    var name: String?
    var dish: DishMenu = DishMenu()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        var dailyMenu: JSObject = [:]
        dish <- map["dishes"]
        dailyMenu <- map["daily_menu"]
        startDate = dailyMenu["start_date"] as? String
        endDate = dailyMenu["end_date"] as? String
    }
}
