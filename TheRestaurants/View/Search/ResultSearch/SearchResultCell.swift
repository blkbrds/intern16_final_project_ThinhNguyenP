//
//  SearchResultCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/3/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var imageSearch: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var delivery: UILabel!

    var viewModel: SearchResultCellModel? {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupView() {
        guard let viewModel = viewModel else { return }
        cityNameLabel.text = viewModel.restaurant.name
        locationLabel.text = viewModel.restaurant.address
        ratingLabel.text = viewModel.restaurant.rating
        delivery.text = "\(viewModel.restaurant.onlineDelivery ?? 0 ) online delivery"
        viewModel.loadImage { [weak self](image) in
            guard let this = self else { return }
            this.imageSearch.image = image
        }
    }
}
