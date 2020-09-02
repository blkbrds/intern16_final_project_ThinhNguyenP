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
enum CellCompletion {
    case success
    case failure(Error)
}

class HomeViewModel {

    enum Cell {
        case collectionView
        case tableView
    }

    var cells: [Cell] = [.collectionView, .tableView]
    var dataCollection: [CollectionRestaurant] = []
    var dataCell: [CellRestaurant] = []

    func loadCollection(value: Int, completion: @escaping (CollectionComplete) -> Void) {
        let param = Api.ListCollection.ListCollectionParam(value: value, key: "city_id")
        Api.ListCollection.loadCollection() { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let collections ):
                this.dataCollection = collections
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadCell(completion: @escaping (CellCompletion) -> Void) {
        Api.ListCell.loadCell { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let cells):
                this.dataCell = cells
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

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
           guard section < cells.count else { return 0 }
           switch cells[section] {
           case .collectionView:
            return dataCollection.count
           case .tableView:
            return dataCell.count
           }
       }
}
