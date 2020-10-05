//
//  MenuCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/27/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    var viewModel: MenuCellModel? {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupView() {
        guard let viewModel = viewModel else { return }
        dishNameLabel.text = viewModel.dailyMenu.dish.dishName
        dishPriceLabel.text = viewModel.dailyMenu.dish.dishPrice
    }
}
