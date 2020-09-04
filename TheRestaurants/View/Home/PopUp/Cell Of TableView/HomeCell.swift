//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var nameRestaurantLabel: UILabel!
    @IBOutlet weak var ratingRestautantLabel: UILabel!
    @IBOutlet weak var addressRestaurantLabel: UILabel!
    @IBOutlet weak var numberOfDeliveryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var viewModel: HomeCellModel? {
        didSet {
            updateView()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.text = viewModel.address
        ratingRestautantLabel.text = viewModel.rating
        numberOfDeliveryLabel.text = "\(String(describing: viewModel.onlineDelivery))"
//        viewModel.loadImage { [weak self](image) in
//            guard let this = self else { return }
//            this.imageRestaurant.layer.cornerRadius = 10
//            this.ratingImage.layer.cornerRadius = 5
//            this.imageRestaurant.image = image
//        }
    }
}
