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
//    func clone() -> PopUpLocation {
//        let popUp = PopUpLocation()
//        popUp.countryName = countryName
//        popUp.cityName = cityName
//        popUp.flagUrl = flagUrl
//        return popUp
//    }
    
    
    // var flagImage: UIImage?
    
//    init(json: JSON) {
//        guard let countryName = json["country_name"] as? String, let cityName = json["name"] as? String, let flagURL = json["country_flag_url"] as? String else { return }
//        self.cityName = cityName
//        self.countryName = countryName
//        self.flagUrl = flagURL
//    }
}
