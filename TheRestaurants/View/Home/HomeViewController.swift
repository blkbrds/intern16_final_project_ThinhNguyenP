//
//  HomeViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadCollection(value: 10)
        loadCell()
       // loadRegularPickerData()
    }

    private func configTableView() {
        let nib = UINib(nibName: "ListCollectionsCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "collectionViewCell")
        let tableNib = UINib(nibName: "HomeCell", bundle: .main)
        tableView.register(tableNib, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadCollection(value: Int) {
        viewModel.loadCollection(value: value) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case.success:
                this.tableView.reloadData()
            case.failure:
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                this.present(alert, animated: true)
            }
        }
    }

    func loadCell() {
        viewModel.loadCell { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case.success:
                this.tableView.reloadData()
            case.failure:
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                this.present(alert, animated: true)
            }
        }
    }

//    private func loadRegularPickerData() {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//        self.loadCollection(value: 10)
//        dispatchGroup.leave()
//        dispatchGroup.enter()
//        self.loadCell()
//        dispatchGroup.leave()
//        dispatchGroup.notify(queue: .main) { [weak self] in
//            guard let this = self else { return }
//            this.tableView.reloadData()
//        }
//    }
    
//    @IBAction func chooseCityButtonTouchUpInside(_ sender: Any) {
//        SceneDelegate.shared.changeRoot(root: .introduce)
//    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cells[indexPath.section] {
        case .collectionView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionViewCell", for: indexPath) as? ListCollectionsCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
            cell.trendingCollectionViewCell.reloadData()
            return cell
        case .tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? HomeCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCell2(indexPath: indexPath)
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
