//
//  ReviewCell.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/15/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var nameUserReview: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var timeReviewLabel: UILabel!
    @IBOutlet private weak var reviewTextLabel: UILabel!
    @IBOutlet private weak var reviewStar: UIStackView!
    @IBOutlet var stars: [UIImageView]!
    var viewModel: ReviewCellModel? {
        didSet {
            setUpView()
        }
    }

    func setUpView() {
        guard let viewModel = viewModel else { return }
        userImage.setImage(url: viewModel.review.userImage)
        userImage.layer.cornerRadius = 15
        nameUserReview.text = viewModel.review.name
        likeLabel.text = "\(viewModel.review.like ?? 0)"
        commentLabel.text = "\(viewModel.review.commentCount ?? 0)"
        timeReviewLabel.text = viewModel.review.reviewTime
        reviewTextLabel.text = viewModel.review.reviewText
        stars.forEach { (starImg) in
            if starImg.tag > viewModel.review.rating ?? 0 {
                starImg.image = #imageLiteral(resourceName: "ic_ratingstar_detail.png")
            }
        }
    }
}
