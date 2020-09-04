//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet private weak var imageRestaurant: UIImageView!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var ratingRestautantLabel: UILabel!
    @IBOutlet private weak var addressRestaurantLabel: UILabel!
    @IBOutlet private weak var numberOfDeliveryLabel: UILabel!

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
        numberOfDeliveryLabel.text = "\(String(describing: viewModel.onlineDelivery))"
    }
}
