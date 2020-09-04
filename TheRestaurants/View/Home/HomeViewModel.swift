//
//  HomeViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class HomeViewModel {

    enum Cell {
        case collectionView
        case tableView
    }

    var cells: [Cell] = [.collectionView, .tableView]
    var dataCollection: [Collection] = []
    var dataCell: [Restaurant] = []

    func numberOfSection() -> Int {
        return cells.count
    }

    func viewModelForCell(indexPath: IndexPath) -> ListCollectionsCellModel {
        let item = dataCollection
        let viewModel = ListCollectionsCellModel(collections: item)
        return viewModel
    }

    func viewModelForCell2(indexPath: IndexPath) -> HomeCellModel {
        let item = dataCell[indexPath.row]
        let viewModel = HomeCellModel(cellsRestaurant: item)
        return viewModel
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard section < cells.count else { return 1 }
        switch cells[section] {
        case .collectionView:
         return 1
        case .tableView:
         return dataCell.count
        }
    }
}
