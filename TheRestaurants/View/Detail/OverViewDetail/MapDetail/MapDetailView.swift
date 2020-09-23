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

    let locationManager = CLLocationManager()
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        addressContainerView.layer.cornerRadius = 5
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        ratingLabel.text = viewModel.restaurant.rating
        voteLabel.text = "\(viewModel.restaurant.votes ?? 0)"
        reviewLabel.text = "\(viewModel.restaurant.review ?? 0 )"
        addressLabel.text = viewModel.restaurant.address
        addAnnotation()
        mapView.delegate = self
    }

    func addAnnotation() {
        guard let viewModel = viewModel, let latitude = viewModel.restaurant.latitudeDouble, let longitude = viewModel.restaurant.longitudeDouble else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: true)
    }
}

extension MapDetailView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.animatesDrop = true
        pin.image = #imageLiteral(resourceName: "ic_pin_detail_overview")
        return pin
    }
}
