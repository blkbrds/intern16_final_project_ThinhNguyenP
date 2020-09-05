//
//  City.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/3/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class City: Object, Mappable {

    var countryName: String = ""
    var cityName: String = ""
    var flagUrl: String = ""
    var id: Int?
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        countryName <- map["country_name"]
        cityName <- map["name"]
        flagUrl <- map ["country_flag_url"]
        id <- map ["id"]
    }
}
