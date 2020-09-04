//
//  HomeViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    func configTableView() {
        let nib = UINib(nibName: "ListCollectionsCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "collectionViewCell")
        let tableNib = UINib(nibName: "HomeCell", bundle: .main)
        tableView.register(tableNib, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionViewCell", for: indexPath) as? ListCollectionsCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
            cell.trendingCollectionViewCell.reloadData()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? HomeCell else { return UITableViewCell() }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.cells[indexPath.section] {
        case .collectionView:
            return 186
        case .tableView:
            return 320
        }
    }
}
