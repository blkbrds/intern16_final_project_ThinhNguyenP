//
//  CuisineView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/6/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class CuisineView: UIView {
    
    @IBOutlet weak var cuisineLabel: UILabel!
    
    var cuisine: [CellRestaurant] = []

    override func  awakeFromNib() {
        super.awakeFromNib()
    }

    func loadCell(completion: @escaping (APICompletion)) {
        Api.ListCell.loadCell { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success(let cells):
                this.cuisine = cells
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func loadCuisine() {
        for item in cuisine {
            let i = item.cuisines?.split(separator: ",")

        }
    }
}

