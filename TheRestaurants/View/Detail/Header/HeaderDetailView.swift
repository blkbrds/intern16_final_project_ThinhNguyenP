//
//  HeaderDetailView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/15/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

protocol HeaderDetailViewDelegate: class {
    func view(_ view: HeaderDetailView, needPerforms action: HeaderDetailView.Action)
}
class HeaderDetailView: UIView {

    enum Action {
        case back
        case favorite(isFavorite: Bool)
    }

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var restaurantImageView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!
    weak var delegate: HeaderDetailViewDelegate?
    var viewModel: HeaderDetailViewModel? {
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

    func xibSetup() {
        let nib = UINib(nibName: "HeaderDetailView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
    }

    @IBAction func favoriteButtonTouchUpInside(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        delegate?.view(self, needPerforms: .favorite(isFavorite: favoriteButton.isSelected))
    }

    func updateView() {
        guard let viewModel = viewModel else { return }
        nameRestaurantLabel.text = viewModel.restaurant.name
        cuisineLabel.text = viewModel.cuisine
        let imageURL = viewModel.restaurant.imageURL?.replacingOccurrences(of: "?output-format=webp", with: "")
        restaurantImageView.setImage(url: imageURL, placeholderImage: #imageLiteral(resourceName: "ic-home-no-image"))
//        favoriteButton.isSelected = viewModel.isFavorite
        favoriteButton.isSelected = viewModel.isFavorite
    }

    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        delegate?.view(self, needPerforms: .back)
    }
}
