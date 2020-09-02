//
//  TableViewCellForCollectionViewModel.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class ListCollectionsCellModel {

    enum LoadCollectionComplete {
        case success
        case failure(Error)
    }
    var collections: [CollectionRestaurant]
    init (collections: [CollectionRestaurant] = [] ) {
        self.collections = collections
    }

    func numberOfRowInSection() -> Int {
        return collections.count
    }

    func viewModelCellForRowAt(indexPath: IndexPath) -> CollectionCellModel {
        let item = collections[indexPath.row]
        let viewModel = CollectionCellModel(listCollection: item)
        return viewModel
    }
}
