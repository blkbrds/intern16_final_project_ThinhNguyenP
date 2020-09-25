//
//  InformationDetailView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/15/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class InformationDetailView: UIView {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var openingTimeLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    var viewModel: InformationDetailViewModel? {
        didSet {
            updateView()
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    func xibSetup() {
        let nib = UINib(nibName: "InformationDetailView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        openingTimeLabel.text = viewModel.openingTime
        phoneNumberLabel.text = viewModel.restaurant.phoneNumber
        websiteLabel.text = viewModel.restaurant.url
    }
}
