//
//  CurrentCollectionCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/9/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class CurrentCollectionCell: UICollectionViewCell {

    @IBOutlet private weak var imageRestaurant: UIImageView!
    @IBOutlet private weak var nameRestaurant: UILabel!
    @IBOutlet private weak var locationRestaurant: UILabel!
    @IBOutlet private weak var typeRestaurant: UILabel!
    @IBOutlet private weak var deliveryLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    var viewModel: CurrentCollectionCellModel? {
        didSet {
            configView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configView() {
        guard let viewModel = viewModel else { return }
        nameRestaurant.text = viewModel.restautant.name
        locationRestaurant.text = viewModel.restautant.address
        deliveryLabel.text = ("\(viewModel.restautant.onlineDelivery ?? 0) now"  )
        ratingLabel.text = ("\(viewModel.restautant.rating ?? "")")
    }
}
