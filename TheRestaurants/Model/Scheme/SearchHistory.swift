//
//  SearchHistory.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation
import RealmSwift
final class SearchHistory: Object {
    @objc dynamic var searchKey: String = ""
}
