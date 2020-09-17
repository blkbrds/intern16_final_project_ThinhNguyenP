//
//  MapDetailView.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/15/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit
import MapKit

class MapDetailView: UIView {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var voteLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!

    var viewModel: MapDetailViewModel? {
        didSet {
            updateView()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    func xibSetup() {
        let nib = UINib(nibName: "MapDetailView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        ratingLabel.text = viewModel.restaurant.rating
        voteLabel.text = "\(viewModel.restaurant.votes ?? 0)"
        reviewLabel.text = "\(viewModel.restaurant.review ?? 0 )"
        addressLabel.text = viewModel.restaurant.address
    }
}
