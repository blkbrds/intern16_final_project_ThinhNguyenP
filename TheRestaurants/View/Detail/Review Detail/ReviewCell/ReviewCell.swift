//
//  ReviewCell.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/15/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameUserReview: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeReviewLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!

    var viewModel: ReviewCellModel? {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    }
}
