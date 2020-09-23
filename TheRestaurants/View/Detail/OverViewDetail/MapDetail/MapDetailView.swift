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
    }
    
    func zoom(location: CLLocation, span: Float) {
        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(span), longitudeDelta: CLLocationDegrees(span))
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func center(location: CLLocation) {
        //center
        mapView.setCenter(location.coordinate, animated: true)
        
        //zoom
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        //show current location
        mapView.showsUserLocation = true
        
        //add 1 pin
        // addAnnotation()
        addAnnotations()
    }
    
    func addAnnotations() {
        
        let pins: [MyPin] = [MyPin(title: "Point 0001", locationName: "Point 0001", coordinate: CLLocationCoordinate2D(latitude: 16.071763, longitude: 108.223963)),
                             MyPin(title: "Point 0002", locationName: "Point 0002", coordinate: CLLocationCoordinate2D(latitude: 16.074443, longitude: 108.224443)),
                             MyPin(title: "Point 0003", locationName: "Point 0003", coordinate: CLLocationCoordinate2D(latitude: 16.073969, longitude: 108.228798)),
                             MyPin(title: "Point 0004", locationName: "Point 0004", coordinate: CLLocationCoordinate2D(latitude: 16.069783, longitude: 108.225086)),
                             MyPin(title: "Point 0005", locationName: "Point 0005", coordinate: CLLocationCoordinate2D(latitude: 16.070629, longitude: 108.228563))]
        
        mapView.addAnnotations(pins)
    }
}
