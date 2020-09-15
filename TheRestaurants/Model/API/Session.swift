//
//  Session.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//
import UIKit

final class Session {

    static var cityId: Int? {
        get {
            if let cityId = UserDefaults.standard.object(forKey: "city id") as? Int {
                return cityId
            } else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "city id")
        }
    }
}
