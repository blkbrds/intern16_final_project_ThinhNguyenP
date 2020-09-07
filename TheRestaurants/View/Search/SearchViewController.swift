//
//  SearchViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var listHistoriedSerch: UITableView!
    @IBOutlet private weak var listResultSearch: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        configTableView()
    }

    var viewModel = SearchViewModel()

    func configTableView() {
        let searchResult = UINib(nibName: "SearchResultCell", bundle: .main)
        listResultSearch.register(searchResult, forCellReuseIdentifier: "searchcell")
        let historySearch = UINib(nibName: "HistorySearchCell", bundle: .main)
        listHistoriedSerch.register(historySearch, forCellReuseIdentifier: "historycell")
        listHistoriedSerch.dataSource = self
        listResultSearch.dataSource = self
    }

    func setupSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 0))
        searchBar.placeholder = "Tìm kiếm địa điểm "
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.search[indexPath.row] {
        case .historySearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistorySearchCell else { return UITableViewCell ()}
            cell.viewModel = viewModel.viewModelForCell(at: indexPath)
            return cell
        case .resultSearch:
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? SearchResultCell else { return UITableViewCell() }
            return cell
        }
    }
}
