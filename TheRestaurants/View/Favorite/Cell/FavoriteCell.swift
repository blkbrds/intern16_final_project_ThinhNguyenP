//
//  FavoriteCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/8/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate: class {
    func cell(_ cell: FavoriteCell, needPerformAction action: FavoriteCell.Action)
}
class FavoriteCell: UITableViewCell {
    enum Action {
        case favorite
    }

    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var removeFavorite: UIButton!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var nameRestaurant: UILabel!
    weak var delegate: FavoriteCellDelegate?

    var viewModel: FavoriteCellModel? {
        didSet {
            setupView()
        }
    }

    func setupView() {
        guard let viewModel = viewModel else { return }
        ratingLabel.text = viewModel.restaurant.rating
        deliveryLabel.text = "\(viewModel.restaurant.onlineDelivery ) now "
        locationLabel.text = viewModel.restaurant.location?.address
        nameRestaurant.text = viewModel.restaurant.name
        ratingLabel.text = viewModel.restaurant.rating
        restaurantImage.setImage(url: viewModel.restaurant.imageURL?.replacingOccurrences(of: "?output-format=webp", with: ""))
    }

    @IBAction func deleteFavoriteButtonTouchUpInside(_ sender: Any) {
        viewModel?.deleteItemFavorite(id: viewModel?.restaurant.id ?? "")
    }
}
