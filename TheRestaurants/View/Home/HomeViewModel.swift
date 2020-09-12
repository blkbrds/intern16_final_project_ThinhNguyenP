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
    var isLoadingMore: Bool = false
    var dataCollection: [Collection] = []
    var dataCell: [Restaurant] = []
    var cells: [Cell] = [.collectionView, .tableView]
    private var start: Int = 0
    private let count = 20

    func loadCollection(completion: @escaping (APICompletion)) {
        let param = Api.ListCollection.ListCollectionParam()
        Api.ListCollection.getCollections(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let cells):
                this.dataCollection = cells
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func loadCell(isLoadMore: Bool = false, completion: @escaping (APICompletion)) {
        if isLoadMore {
            start += count
        } else {
            start = 0
        }
        let param = Api.ListCell.SearchParam(city: "city", start: start)
        Api.ListCell.getRestaurants(param: param) { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case .success(let cells):
                if isLoadMore {
                    this.dataCell.append(contentsOf: cells)
                } else {
                    this.dataCell = cells
                }
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
