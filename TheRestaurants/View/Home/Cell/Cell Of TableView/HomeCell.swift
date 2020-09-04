//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var ratingImage: UIView!
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var nameRestaurantLabel: UILabel!
    @IBOutlet weak var ratingRestautantLabel: UILabel!
    @IBOutlet weak var addressRestaurantLabel: UILabel!
    @IBOutlet weak var numberOfDeliveryLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var cuisines: UILabel!
    var viewModel: HomeCellModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.text = viewModel.address
        cuisines.text = viewModel.cuisines
        ratingRestautantLabel.text = viewModel.rating
        numberOfDeliveryLabel.text = "\(viewModel.onlineDelivery ?? 0)"
        favoriteButton.isSelected = viewModel.isFavorite
        viewModel.loadImage { [weak self](image) in
            guard let this = self else { return }
            this.imageRestaurant.layer.cornerRadius = 10
            this.ratingImage.layer.cornerRadius = 5
            this.imageRestaurant.image = image
        }
    }
}
