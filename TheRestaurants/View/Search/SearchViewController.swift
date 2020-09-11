//
//  SearchViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet private weak var listHistoriedSerch: UITableView!
    @IBOutlet private weak var listResultSearch: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
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

    func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 35, height: 0))
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textfield.placeholder = "Tìm kiếm địa điểm "
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5125578704)
            }
        }
         navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
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
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? HomeCell else { return UITableViewCell() }
            return cell
        }
    }
}
