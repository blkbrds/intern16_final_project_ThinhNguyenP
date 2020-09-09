//
//  MapViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel = MapViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }

    private func configCollectionView() {
        let nib = UINib(nibName: "CurrentCollectionCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 5
    }
}
extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CurrentCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}
extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 311, height: 116)
    }
}
