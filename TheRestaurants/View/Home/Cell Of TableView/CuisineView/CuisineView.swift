//
//  CuisineView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class CuisineView: UIView {

    @IBOutlet weak var cuisineView: UIView!
    @IBOutlet weak var cuisineLabel: UILabel!

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
        cuisineView.layer.cornerRadius = 10
        cuisineView.layer.borderWidth = 1
        cuisineView.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.5333333333, blue: 0.8196078431, alpha: 1)
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        if viewModel.isTitle {
            cuisineLabel.font = .systemFont(ofSize: 13, weight: .medium)
            cuisineLabel.textColor = .white
            cuisineView.backgroundColor = #colorLiteral(red: 0.007843137255, green: 0.5333333333, blue: 0.8196078431, alpha: 1)
        } else {
            cuisineLabel.font = .systemFont(ofSize: 12)
            cuisineLabel.textColor = .black
            cuisineView.backgroundColor = .clear
        }
        cuisineLabel.text = viewModel.cuisine
    }
}
