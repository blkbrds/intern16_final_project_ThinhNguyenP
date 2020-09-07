//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var cuisineView: UIView!
    @IBOutlet private weak var imageRestaurant: UIImageView!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var ratingRestautantLabel: UILabel!
    @IBOutlet private weak var addressRestaurantLabel: UILabel!
    @IBOutlet private weak var numberOfDeliveryLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var favoriteButtonTouchUpInside: UIButton!
    var viewModel: HomeCellModel? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.text = viewModel.address
        ratingRestautantLabel.text = viewModel.rating
        cuisineLabel.text = viewModel.cuisines
        numberOfDeliveryLabel.text = "\(viewModel.onlineDelivery ?? 0) online delivery now"
        viewModel.loadImage { [weak self](image) in
            guard let this = self else { return }
            this.imageRestaurant.layer.cornerRadius = 10
            this.imageRestaurant.image = image
        }
    }
}
