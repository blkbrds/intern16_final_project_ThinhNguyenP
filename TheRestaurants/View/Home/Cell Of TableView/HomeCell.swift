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
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.text = viewModel.address
        ratingRestautantLabel.text = viewModel.rating
        numberOfDeliveryLabel.text = "\(viewModel.onlineDelivery ?? 0) online delivery now"
//        viewModel.loadImage { [weak self](image) in
//            guard let this = self else { return }
//            this.imageRestaurant.layer.cornerRadius = 10
//            this.imageRestaurant.image = image
//        }
        configCuisineStackView()
    }

    private func configCuisineStackView() {
        guard let cuisineArr = viewModel?.cuisineArr, !cuisineArr.isEmpty else { return }
        a(arr: cuisineArr, startIndex: 0, widthLimit: cuisineStackView.frame.width)
    }

    private func a(arr: [String], startIndex: Int, widthLimit: CGFloat) {
        guard startIndex < arr.count else { return }
        let stackView = UIStackView()
        stackView.spacing = 8
        var widthPerRow: CGFloat = 0.0
        for j in startIndex...arr.count {
            if widthPerRow > widthLimit {
                cuisineStackView.addSubview(stackView)
                a(arr: arr, startIndex: j + 1, widthLimit: widthLimit)
            } else {
                let isTitle = arr[j].elementsEqual("Cuisine")
                let font: UIFont = isTitle ? .systemFont(ofSize: 13, weight: .medium) : .systemFont(ofSize: 12)
                let cuisineViewWidth = arr[j].contentWidth(font: font)
                let cuisineView = CuisineView(frame: CGRect(x: 0, y: 0, width: cuisineViewWidth, height: 18))
                cuisineView.viewModel = CuisineViewModel(cuisine: arr[j], isTitle: isTitle)
                stackView.addSubview(cuisineView)

                widthPerRow += cuisineViewWidth + 8
                if j < arr.count - 1 {
                    widthPerRow += arr[j + 1].contentWidth(font: .systemFont(ofSize: 12))
                }
            }
        }
    }
}
