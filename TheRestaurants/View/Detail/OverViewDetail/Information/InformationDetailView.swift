//
//  InformationDetailView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/15/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

final class InformationDetailView: UIView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var openingTimeLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!

    var viewModel: InformationDetailViewModel? {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    private func xibSetup() {
        let nib = UINib(nibName: "InformationDetailView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
        containerView.fillToSuperview()
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        openingTimeLabel.attributedText = viewModel.openingTime.addLineSpacing(3, alingment: .right)
        phoneNumberLabel.attributedText = viewModel.phoneNumber.addLineSpacing(3, alingment: .right)
        websiteLabel.text = viewModel.restaurant.url
    }
}
