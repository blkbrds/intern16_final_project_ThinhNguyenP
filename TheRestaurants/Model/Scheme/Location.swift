//
//  Location.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/25/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
class Location: Object, Mappable {

    var latitude: Double?
    var longitude: Double?
    @objc dynamic var address: String?

    required convenience init?(map: Map) {
          self.init()
    }

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
