//
//  HomeViewModel.swift
//  Bai2Review
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import Foundation

class HomeViewModel {
    var id : [String]
    init(id: [String] = []) {
        self.id = id
    }
    
    func numberOfRowInSection() -> Int {
        return id.count
    }
    func viewModelForCell(indexPath: IndexPath) -> HomeCellModel {
        let item = id[indexPath.row]
        let viewModel = HomeCellModel(id: item)
        return viewModel
    }
    
    func didSelectRowAt(indexPath: IndexPath) -> DetailViewController {
        let item = id[indexPath.row]
        let detail = DetailViewController()
        DetailViewController.name = item
        return detail
    }
}
