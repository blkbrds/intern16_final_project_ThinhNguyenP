//
//  HeaderDetailView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/15/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HeaderDetailView: UIView {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!

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
