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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
