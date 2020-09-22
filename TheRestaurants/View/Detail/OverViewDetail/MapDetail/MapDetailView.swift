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

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var voteLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var addressContainerView: UIView!
    @IBOutlet private weak var addressLabel: UILabel!

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

    override func awakeFromNib() {
        super.awakeFromNib()
        addressContainerView.layer.cornerRadius = 5
    }
}
