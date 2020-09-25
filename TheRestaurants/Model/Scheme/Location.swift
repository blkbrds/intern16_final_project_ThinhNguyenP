//
//  Location.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/25/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
    required convenience init?(map: Map) {
        self.init()
    }

    var latitude: Double?
    var longitude: Double?
    var address: String?

    func mapping(map: Map) {
        var latitude: String = ""
        var longitude: String = ""
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        self.latitude = Double(latitude)
        self.longitude = Double(longitude)
        address <- map["address"]
    }
}
