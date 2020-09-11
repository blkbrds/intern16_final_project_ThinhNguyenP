//
//  SearchViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

enum Search {
    case resultSearch
    case historySearch
}

class SearchViewModel {
    var result: [City] = []
    var search: [Search] = [.resultSearch, .historySearch]
    var history: [SearchHistory] = []

    func numberOfRowsInSection(section: Int) -> Int {
        switch search[section] {
        case .historySearch:
            return history.count
        case .resultSearch:
            return result.count
        }
    }

    func viewModelForCell(at indexPath: IndexPath) -> HistorySearchCellModel {
        let item = history[indexPath.row]
        let viewModel = HistorySearchCellModel(searchHistory: item)
        return viewModel
    }
}
