//
//  HomeViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadCollection()
        loadCell()
    }

    override func customNavigation() {
        super.customNavigation()
        navigationItem.title = "Home"
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-return introduce -home"), style: .plain, target: self, action: #selector(changeLocationButtonTouchUpInside))
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = button
    }

    @objc func changeLocationButtonTouchUpInside() {
        Session.cityId = nil
        SceneDelegate.shared.changeRoot(root: .introduce)
    }

    private func configTableView() {
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        let nib = UINib(nibName: "ListCollectionsCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "collectionViewCell")
        let tableNib = UINib(nibName: "HomeCell", bundle: .main)
        tableView.register(tableNib, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func loadCollection() {
        Indicator.start()
        viewModel.loadCollection { [weak self](result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func loadCell(isLoadMore: Bool = false) {
        Indicator.start()
        viewModel.loadCell(isLoadMore: isLoadMore) { [weak self] (result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case.success:
                this.tableView.reloadData()
            case.failure(let error):
                this.alert(error: error)
            }
        }
    }
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionViewCell", for: indexPath)
                as? ListCollectionsCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCell(indexPath: indexPath)
            cell.trendingCollectionViewCell.reloadData()
            return cell
        case .tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
                as? HomeCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCell2(indexPath: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.cells[indexPath.section] {
        case .collectionView:
            return 186
        case .tableView:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.viewModel.restaurant = viewModel.restaurants[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
    }
}
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.canLoadMore else { return }
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if !viewModel.isLoadingMore && (maximumOffset - contentOffset <= 100) {
            loadCell(isLoadMore: true)
        }
    }
}
