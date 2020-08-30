
//  PopUpSearch.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/27/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class City: Decodable {
    var countryName: String = ""
    var cityName: String = ""
    var flagUrl: String = ""

    init(json: JSObject) {
        guard let countryName = json["country_name"] as? String, let cityName = json["name"] as? String, let flagURL = json["country_flag_url"] as? String else { return }
        self.cityName = cityName
        self.countryName = countryName
        self.flagUrl = flagURL
    }
}
