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
        fetchData()
    }

    private func addRealm(searchKey: String) {
        viewModel.addRealm(searchKey: searchKey) { (done) in
            if done {
                self.fetchData()
            } else {
                print("")
            }
        }
    }

    var viewModel = SearchViewModel()
    
    func configTableView() {
        let searchResult = UINib(nibName: "HomeCell", bundle: .main)
        listResultSearch.register(searchResult, forCellReuseIdentifier: "searchcell")
        let historySearch = UINib(nibName: "HistorySearchCell", bundle: .main)
        listHistoriedSerch.register(historySearch, forCellReuseIdentifier: "historycell")
        listHistoriedSerch.dataSource = self
        listResultSearch.dataSource = self
    }

    func loadCell(keywork: String) {
        Indicator.start()
        viewModel.getResult(keywork: keywork) { [weak self ](result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case.success:
                this.listResultSearch.reloadData()
            case.failure(let error):
                this.alert(error: error)
            }
        }
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
        searchBar.delegate = self 
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }

    func fetchData() {
        viewModel.fetchData { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case.success:
                this.listHistoriedSerch.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listHistoriedSerch {
            return viewModel.numberOfRowInSectionHistoried()
        }
        return viewModel.numberOfRowInSectionResult()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listResultSearch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistorySearchCell else { return UITableViewCell()}
            cell.viewModel = viewModel.viewModelForCellHistoried(at: indexPath)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? HomeCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCellResult(indexPath: indexPath)
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else { return }
        loadCell(keywork: value)
        addRealm(searchKey: value)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {

        listHistoriedSerch.isHidden = false
        listResultSearch.isHidden = true
        fetchData()
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        listHistoriedSerch.isHidden = true
        return true
    }
}
