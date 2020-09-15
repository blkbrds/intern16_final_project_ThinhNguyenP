//
//  FavoriteCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var removeFavorite: UIButton!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var nameRestaurant: UILabel!

    var viewModel: FavoriteCellModel? {
        didSet {
            setupView()
        }
    }

    func setupView() {
        guard let viewModel = viewModel else { return }
        ratingLabel.text = viewModel.restaurant.rating
        deliveryLabel.text = "\(viewModel.restaurant.onlineDelivery ?? 0) now "
        locationLabel.text = viewModel.restaurant.address
        nameRestaurant.text = viewModel.restaurant.name
    }

    @IBAction func deleteFavoriteButtonTouchUpInside(_ sender: Any) { }
}
