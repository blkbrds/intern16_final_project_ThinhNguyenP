//
//  HomeTableViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/30/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

protocol HomeCellDelegate: class {
    func cell(_ cell: HomeCell, needPerform action: HomeCell.Action)
}
class HomeCell: UITableViewCell {
    enum Action {
        case favorite(isFavorite: Bool)
//        case removeFavorite(id: String)
    }
    @IBOutlet private weak var imageRestaurant: UIImageView!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var ratingRestautantLabel: UILabel!
    @IBOutlet private weak var cuisineStackView: UIStackView!
    @IBOutlet private weak var addressRestaurantLabel: UILabel!
    @IBOutlet private weak var numberOfDeliveryLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    weak var delegate: HomeCellDelegate?

    var viewModel: HomeCellModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageRestaurant.layer.cornerRadius = 10
        ratingView.layer.cornerRadius = 3
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        imageRestaurant.setImage(url: viewModel.imageURL, placeholderImage: #imageLiteral(resourceName: "ic-home-no-image"))
        nameRestaurantLabel.text = viewModel.name
        addressRestaurantLabel.attributedText = viewModel.address?.addLineSpacing(3)
        ratingRestautantLabel.text = viewModel.rating
        numberOfDeliveryLabel.text = "\(viewModel.onlineDelivery ?? 0) online delivery now"
        configCuisineStackView()
        favoriteButton.isSelected = viewModel.isFavorite
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
        stackView.spacing = Config.stackViewInRowSpacing
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        var widthPerRow: CGFloat = 0.0
        var nextCuisineViewWidth: CGFloat = 0.0
        for index in startIndex...arr.count - 1 {
            if widthPerRow > widthLimit {
                cuisineStackView.addArrangedSubview(stackView)
                return index
            } else {
                widthPerRow -= nextCuisineViewWidth
                let item = arr[index].trimmed
                let isTitle = item.elementsEqual("Cuisine")
                let font: UIFont = isTitle ? CuisineView.Config.cuisineLabelTitleFont : CuisineView.Config.cuisineLabelFont
                let cuisineViewWidth = item.contentWidth(font: font) + CuisineView.Config.cuisineLabelMargin * 2
                let cuisineView: CuisineView = CuisineView.loadNib()
                cuisineView.frame = CGRect(x: 0, y: 0, width: cuisineViewWidth, height: 18)
                cuisineView.viewModel = CuisineViewModel(cuisine: item, isTitle: isTitle)
                stackView.addArrangedSubview(cuisineView)

                widthPerRow += cuisineViewWidth + Config.stackViewInRowSpacing
                if index < arr.count - 1 {
                    let nextItem = arr[index + 1].trimmed
                    nextCuisineViewWidth = nextItem.contentWidth(font: CuisineView.Config.cuisineLabelFont)
                        + CuisineView.Config.cuisineLabelMargin * 2
                    widthPerRow += nextCuisineViewWidth + Config.stackViewInRowSpacing
                }
            }
        }
        cuisineStackView.addArrangedSubview(stackView)
        return -1
    }

    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needPerform: .favorite(isFavorite: favoriteButton.isSelected))
    }
}

extension HomeCell {
    struct Config {
        static let stackViewInRowSpacing: CGFloat = 8
    }
}
