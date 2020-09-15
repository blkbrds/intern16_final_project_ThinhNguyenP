//
//  TableViewCellForCollectionViewCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/31/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ListCollectionsCell: UITableViewCell {

    @IBOutlet weak var trendingCollectionViewCell: UICollectionView!

    var viewModel = ListCollectionsCellModel()

    override func awakeFromNib() {
           super.awakeFromNib()
           configCollectionView()
       }

    private func configCollectionView() {
        let collectionView = UINib(nibName: "CollectionCell", bundle: .main)
        trendingCollectionViewCell.register(collectionView, forCellWithReuseIdentifier: "collectionView")
        trendingCollectionViewCell.dataSource = self
        trendingCollectionViewCell.delegate = self
    }
}
extension ListCollectionsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath)
            as? CollectionCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.viewModelCellForRowAt(indexPath: indexPath)
        return cell
    }
}
extension ListCollectionsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
