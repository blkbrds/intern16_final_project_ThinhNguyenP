//
//  SearchViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet private weak var searchHistoryTableView: UITableView!
    @IBOutlet private weak var resultTableView: UITableView!

    var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        configTableView()
        fetchSearchHistoryData()
    }

    private func saveKeyToRealm(searchKey: String) {
        viewModel.saveKeyToRealm(searchKey: searchKey) {  [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case.success:
                this.searchHistoryTableView.reloadData()
            case.failure(let error):
                this.alert(error: error)
            }
        }
    }

    func configTableView() {
        let searchResult = UINib(nibName: "HomeCell", bundle: .main)
        resultTableView.register(searchResult, forCellReuseIdentifier: "searchcell")
        let historySearch = UINib(nibName: "HistorySearchCell", bundle: .main)
        searchHistoryTableView.register(historySearch, forCellReuseIdentifier: "historycell")
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }

    func searchRestaurants(keyword: String) {
        searchHistoryTableView.isHidden = true
        resultTableView.isHidden = false
        Indicator.start()
        viewModel.getResult(keywork: keyword) { [weak self ](result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case.success:
                this.resultTableView.reloadData()
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

    func fetchSearchHistoryData() {
        viewModel.fetchSearchHistoryData { [weak self ](result) in
            guard let this = self else { return }
            switch result {
            case.success:
                this.searchHistoryTableView.reloadData()
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchHistoryTableView {
            return viewModel.numberOfRowInSectionHistoried()
        }
        return viewModel.numberOfRowInSectionResult()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
        switch viewModel.search[indexPath.row] {
        case .historySearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistorySearchCell else { return UITableViewCell()}
            cell.viewModel = viewModel.viewModelForCell(at: indexPath)
            return cell
        case .resultSearch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? HomeCell else { return UITableViewCell() }
=======
        if tableView == searchHistoryTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistorySearchCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForHistoryCell(at: indexPath)
>>>>>>> master
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.viewModelForResultCell(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == resultTableView {
            let viewController = DetailViewController()
            viewController.viewModel = viewModel.didSelectRowAt(indexPath: indexPath)
            viewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let keywork = viewModel.histories[indexPath.row].searchKey
            searchRestaurants(keyword: keywork)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else { return }
        saveKeyToRealm(searchKey: value)
        searchRestaurants(keyword: value)
        searchBar.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchHistoryTableView.isHidden = false
        resultTableView.isHidden = true
        fetchSearchHistoryData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchHistoryTableView.isHidden = true
        resultTableView.isHidden = false
    }
}
