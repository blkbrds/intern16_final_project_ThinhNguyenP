//
//  FavoriteViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class FavoriteViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setUpNavigation()
        viewModel.setupObserve()
        viewModel.feachRealm()
    }

    private func configTableView() {
        let nib = UINib(nibName: "FavoriteCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.rowHeight = 121
    }

    private func setUpNavigation() {
        let deleteAll = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_trash"), style: .plain, target: self, action: #selector(deleteAllFavoriteButtonTouchUpInside))
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.title = "Favorite List"
        navigationItem.rightBarButtonItem = deleteAll
    }

    @objc func deleteAllFavoriteButtonTouchUpInside() { }
}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoriteCell else { return UITableViewCell()}
        cell.viewModel = viewModel.cellForItemAt(indexPath: indexPath)
        return cell
    }
}
//extension FavoriteViewController : FavoriteViewModelDelegate {
//    func syncFavorite(viewModel: FavoriteViewModel, needperformAction action: FavoriteViewModel.Action) {
//        <#code#>
//    }
//
//    func viewModel(_ viewModel: FavoriteViewController, needperfomAction action: FavoriteViewModel.Action) {
//
//    }
//}
