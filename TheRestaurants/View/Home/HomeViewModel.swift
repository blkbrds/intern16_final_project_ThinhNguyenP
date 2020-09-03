//
//  HomeViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

enum Cell {
    case collectionView
    case tableView
}
enum CollectionComplete {
    case success
    case failure(Error)
}

class HomeViewModel {

    enum Cell {
        case collectionView
        case tableView
    }

    var cells: [Cell] = [.collectionView, .tableView]
    var dataCollection: [CollecitonRestaurant] = []

    func numberOfSection() -> Int {
        return cells.count
    }

    func viewModelForCell(indexPath: IndexPath) -> ListCollectionsCellModel {
        let item = dataCollection
        let viewModel = ListCollectionsCellModel(collections: item)
        return viewModel
    }
}
