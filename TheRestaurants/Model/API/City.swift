//
//  PopUpSearch.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/27/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers class City: Object, Mappable {

    var countryName: String = ""
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
