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
        listResultSearch.rowHeight = 300
        let historySearch = UINib(nibName: "HistorySearchCell", bundle: .main)
        listHistoriedSerch.register(historySearch, forCellReuseIdentifier: "historycell")
        listHistoriedSerch.dataSource = self
        listResultSearch.dataSource = self
    }

    func getSearchResult(value: String) {
        viewModel.getResult(keywork: value) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.listHistoriedSerch.isHidden = true
                this.listResultSearch.reloadData()
            case .failure:
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                this.present(alert, animated: true)
            }
        }
    }

    func setUpSearchBar() {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 35, height: 0))
        searchBar.delegate = self
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
        if tableView == listHistoriedSerch {
            return viewModel.numberOfRowInSectionHistoried()
        } else {
            return viewModel.numberOfRowInSectionResult()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listResultSearch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? SearchResultCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCellResult(indexPath: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistorySearchCell else { return UITableViewCell() }
            cell.viewModel = viewModel.viewModelForCellHistoried(at: indexPath)
            return cell
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        getSearchResult(value: keyword)
    }
}
