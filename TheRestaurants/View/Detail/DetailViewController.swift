//
//  DetailViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var previousScreenButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    @IBOutlet private weak var reviewCountLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var openTimingLabel: UILabel!
    @IBOutlet private weak var urlRestaurantLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
