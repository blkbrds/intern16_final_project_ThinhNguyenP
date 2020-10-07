//
//  InformationDetailViewModel.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/23/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

final class InformationDetailViewModel {

    var restaurant: Restaurant
    var openingTime: String {
        guard let timing = restaurant.timings else { return "" }
        let timingArr = timing.split(separator: ",")
        var resultArr: [String] = []
        for (index, str) in timingArr.enumerated() {
            if let firstCharacter = String(str).trimmed.first, !firstCharacter.isNumber, index > 0 {
                resultArr.removeLast()
                let newStr = "\(timingArr[index - 1])" + ",\(str)".trimmed
                resultArr.append(newStr)
            } else {
                resultArr.append(String(str).trimmed)
            }
        }
        return resultArr.joined(separator: "\n")
    }

    var phoneNumber: String {
        guard let phoneNumber = restaurant.phoneNumber else { return "" }
        return phoneNumber.replacingOccurrences(of: ", ", with: "\n")
    }

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
