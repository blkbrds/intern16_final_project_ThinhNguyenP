//
//  HightlightView.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/18/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

final class HightlightView: UIView {

    @IBOutlet weak var contentLabel: UILabel!

    var viewModel: HightlightViewModel? {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        contentLabel.text = viewModel?.content
    }
}