//
//  CollectionCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/4/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

final class CollectionCell: UICollectionViewCell {

    @IBOutlet private weak var imageCollectionView: UIImageView!
    @IBOutlet private weak var nameCollectionLabel: UILabel!
    @IBOutlet private weak var countPlacesTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var viewModel: CollectionCellModel? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameCollectionLabel.text = viewModel.title
        imageCollectionView.setImage(url: viewModel.imageUrl, placeholderImage: #imageLiteral(resourceName: "ic-home-no-image"))
        imageCollectionView.layer.cornerRadius = 10
        countPlacesTitle.text = "\(viewModel.numberOfRestaurant ?? 0) places"
    }
}
