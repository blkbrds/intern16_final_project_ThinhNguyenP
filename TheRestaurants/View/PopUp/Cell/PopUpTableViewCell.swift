//
//  PopUpTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/26/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class PopUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var viewModel: PopUpTableViewModel? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI () {
        guard let viewModel = viewModel else {return }
        flagImageView.layer.cornerRadius = 10
        flagImageView.clipsToBounds = true
        cityNameLabel.text = viewModel.city.cityName
        countryNameLabel.text = viewModel.city.countryName
        viewModel.loadImage { [weak self] (image) in
            guard let `self` = self else { return}
            self.flagImageView.image = image
        }
    }
}
