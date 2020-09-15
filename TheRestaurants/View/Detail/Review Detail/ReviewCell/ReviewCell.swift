//
//  ReviewCell.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/15/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameUserReview: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeReviewLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpView() { }
}
