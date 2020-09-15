//
//  DetailOverViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet private weak var imageDetail: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameRestaurantLabel: UILabel!
    @IBOutlet private weak var cuisineLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var likedLabel: UILabel!
    @IBOutlet private weak var addressLabel: UIScrollView!
    @IBOutlet private weak var openingHourLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var websiteUrlLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
