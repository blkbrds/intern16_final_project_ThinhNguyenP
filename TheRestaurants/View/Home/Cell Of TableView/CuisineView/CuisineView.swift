//
//  CuisineView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class CuisineView: UIView {

    @IBOutlet private weak var cuisineView: UIView!
    @IBOutlet private weak var cuisineLabel: UILabel!

    var viewModel: CuisineViewModel? {
        didSet {
            updateUI()
        }
    }

    override func  awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        cuisineView.layer.cornerRadius = 3
        cuisineView.layer.borderWidth = 1
        cuisineView.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.5333333333, blue: 0.8196078431, alpha: 1)
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        if viewModel.isTitle {
            cuisineLabel.font = Config.cuisineLabelTitleFont
            cuisineLabel.textColor = .white
            cuisineView.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.5333333333, blue: 0.8196078431, alpha: 1)
        } else {
            cuisineLabel.font = Config.cuisineLabelFont
            cuisineLabel.textColor = .black
            cuisineView.backgroundColor = .clear
        }
        cuisineLabel.text = viewModel.cuisine
    }
}

extension CuisineView {
    struct Config {
        static let cuisineLabelTitleFont: UIFont = .systemFont(ofSize: 13, weight: .medium)
        static let cuisineLabelFont: UIFont = .systemFont(ofSize: 12)
        static let cuisineLabelMargin: CGFloat = 6
    }
}