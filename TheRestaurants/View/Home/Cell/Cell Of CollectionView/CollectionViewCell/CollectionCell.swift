//
//  HomeCollectionViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageCollectionView: UIImageView!
    @IBOutlet weak var nameCollectionLabel: UILabel!
    @IBOutlet weak var countPlacesTitle: UILabel!

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
        countPlacesTitle.text = "\(viewModel.numberOfRestaurant) places "
        viewModel.loadImage { [weak self ](image) in
            guard let this = self else { return }
            this.imageCollectionView.image = image
        }
    }
}
