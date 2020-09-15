//
//  HeaderDetailView.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/14/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HeaderDetailView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var nameRestaurantLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    func xibSetup() {
        let nib = UINib(nibName: "HeaderDetailView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
    }

}
