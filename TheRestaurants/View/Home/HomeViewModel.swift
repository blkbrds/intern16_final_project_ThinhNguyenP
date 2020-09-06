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
    var dataCollection: [Collection] = []
    var dataCell: [CellRestaurant] = []
    var cells: [Cell] = [.collectionView, .tableView]

    func loadCollection(value: Int, completion: @escaping (APICompletion)) {
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

    func loadCell(completion: @escaping (APICompletion)) {
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
        guard section < cells.count else { return 1 }
        switch cells[section] {
        case .collectionView:
            return 1
        case .tableView:
            return dataCell.count
        }
    }
}