//
//  HomeViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadCollection()
        loadCell(isLoadMore: false)
        viewModel.delegate = self
        viewModel.setupObserver()
    }

    override func customNavigation() {
        super.customNavigation()
        navigationItem.title = "Home"
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "ic-return introduce -home"), style: .plain, target: self, action: #selector(changeLocationButtonTouchUpInside))
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = button
    }

    @objc func changeLocationButtonTouchUpInside() {
        let vc = SearchCityPopUpViewController()
        tabBarController?.present(vc, animated: true)
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
            cell.viewModel = viewModel.viewModelForListCollection(indexPath: indexPath)
            cell.trendingCollectionViewCell.reloadData()
            return cell
        case .tableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
                as? HomeCell else { return UITableViewCell() }
            cell.delegate = self
            cell.viewModel = viewModel.viewModelForHomeCell(indexPath: indexPath)
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
        switch viewModel.cells[indexPath.section] {
        case .collectionView:
            break
        case .tableView:
            let viewController = DetailViewController()
            viewController.viewModel = viewModel.didSelectRowAt(indexPath: indexPath)
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard viewModel.canLoadMore else { return }
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if !viewModel.isLoadingMore && (maximumOffset - contentOffset <= 10) {
            loadCell(isLoadMore: true)
        }
    }
}
extension HomeViewController: HomeCellDelegate {
    func cell(_ cell: HomeCell, needPerform action: HomeCell.Action) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        switch action {
        case .favorite(let isFavorite):
            if isFavorite {
                viewModel.unfavorite(index: indexPath.row) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.tableView.reloadData()
                    case.failure(let error):
                        this.alert(error: error)
                    }
                }
            } else {
                viewModel.addFavorite(index: indexPath.row) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.tableView.reloadData()
                    case .failure(let error):
                        this.alert(error: error)
                    }
                }
            }
        }
    }
}
extension HomeViewController: HomeViewModelDelegate {
    func syncFavorite(viewModel: HomeViewModel, needPerform action: HomeViewModel.Action) {
        switch action {
        case .reloadData:
            tableView.reloadData()
        case .fail(let error):
            alert(error: error)
        }
    }
}
