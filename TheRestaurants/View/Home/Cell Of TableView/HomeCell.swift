//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet private weak var imageRestaurant: UIImageView!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var ratingRestautantLabel: UILabel!
    @IBOutlet private weak var cuisineStackView: UIStackView!
    @IBOutlet private weak var addressRestaurantLabel: UILabel!
    @IBOutlet private weak var numberOfDeliveryLabel: UILabel!

    var viewModel: HomeCellModel? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        imageRestaurant.layer.cornerRadius = 10
        imageRestaurant.setImage(url: viewModel.imageURL, placeholderImage: #imageLiteral(resourceName: "ic-home-no-image"))
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.text = viewModel.address
        ratingRestautantLabel.text = viewModel.rating
        numberOfDeliveryLabel.text = "\(viewModel.onlineDelivery ?? 0) online delivery now"
        configCuisineStackView()
    }

    private func configCuisineStackView() {
        guard let cuisineArr = viewModel?.cuisineArr, !cuisineArr.isEmpty else {
            cuisineStackView.isHidden = true
            return
        }
        cuisineStackView.isHidden = false
        cuisineStackView.removeAllArrangedSubviews()
        var startIndex = 0
        while startIndex < cuisineArr.count && startIndex != -1 {
            startIndex = configStackViewPerRow(arr: cuisineArr, startIndex: startIndex, widthLimit: cuisineStackView.frame.width)
        }
    }

    private func configStackViewPerRow(arr: [String], startIndex: Int, widthLimit: CGFloat) -> Int {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        var widthPerRow: CGFloat = 0.0
        var nextCuisineViewWidth: CGFloat = 0.0
        for j in startIndex...arr.count - 1 {
            if widthPerRow > widthLimit {
                cuisineStackView.addArrangedSubview(stackView)
                return j
            } else {
                widthPerRow -= nextCuisineViewWidth
                let item = arr[j].trimmed
                let isTitle = item.elementsEqual("Cuisine")
                let font: UIFont = isTitle ? .systemFont(ofSize: 13, weight: .medium) : .systemFont(ofSize: 12)
                let cuisineViewWidth = item.contentWidth(font: font) + 6 * 2
                let cuisineView: CuisineView = CuisineView.loadNib()
                cuisineView.frame = CGRect(x: 0, y: 0, width: cuisineViewWidth, height: 18)
                cuisineView.viewModel = CuisineViewModel(cuisine: item, isTitle: isTitle)
                stackView.addArrangedSubview(cuisineView)

                widthPerRow += cuisineViewWidth + 8
                if j < arr.count - 1 {
                    nextCuisineViewWidth = arr[j + 1].trimmed.contentWidth(font: .systemFont(ofSize: 12)) + 6 * 2
                    widthPerRow += nextCuisineViewWidth + 8
                }
            }
        }
        cuisineStackView.addArrangedSubview(stackView)
        return -1
    }
}
