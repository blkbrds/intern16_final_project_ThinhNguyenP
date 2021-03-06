//
//  PopUpTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

final class SearchCityCell: UITableViewCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var countryNameLabel: UILabel!

    var viewModel: SearchCityCellModel? {
        didSet {
            updateUI()
        }
    }

    private func updateUI () {
        guard let viewModel = viewModel else { return }
        flagImageView.layer.cornerRadius = 10
        flagImageView.clipsToBounds = true
        cityNameLabel.text = viewModel.city.cityName
        countryNameLabel.text = viewModel.city.countryName
        flagImageView.setImage(url: viewModel.city.flagUrl, placeholderImage: #imageLiteral(resourceName: "ic-home-no-image"))
    }
}
