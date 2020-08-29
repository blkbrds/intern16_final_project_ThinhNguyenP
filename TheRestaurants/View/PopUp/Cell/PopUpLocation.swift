//
//  PopUpLocation.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers class PopUpLocation: Object, Mappable {

    dynamic var countryName: String = ""
    var cityName: String = ""
    var flagUrl: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        countryName <- map["country_name"]
        cityName <- map["name"]
        flagUrl <- map ["country_flag_url"]
    }
}
