//
//  HistorySearchViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

final class HistorySearchCellModel {
    var searchKey: String
    init(searchHistory: SearchHistory) {
        searchKey = searchHistory.searchKey
    }
}
