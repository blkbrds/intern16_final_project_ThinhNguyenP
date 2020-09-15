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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
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
    
}

