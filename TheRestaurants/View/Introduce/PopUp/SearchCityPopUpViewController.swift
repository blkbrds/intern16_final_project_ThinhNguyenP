//
//  PopUpViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 8/25/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit
import Contacts
import SVProgressHUD

class SearchCityPopUpViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTitleLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    var viewModel = SearchCityPopUpViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        searchBar.delegate = self
    }

    private func setup() {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }

    func configTableView() {
        let nib = UINib(nibName: "SearchCityCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func updateUI() {
        tableView.reloadData()
    }

    func search(value: String) {
        viewModel.searchCities(value: value) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure:
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                this.present(alert, animated: true)
            }
        }
    }

    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension SearchCityPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInsection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? SearchCityCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       as? SearchCityCell else { return }
        let cellViewModel = viewModel.didSelectRowAt(value: indexPath.row)
        cell.viewModel = cellViewModel
        let cityId = cellViewModel.city.id
        UserDefaults.standard.set(cityId, forKey: "curren_city_id")
        SceneDelegate.shared.changeRoot(root: .tabbar)
    }
}

extension SearchCityPopUpViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else { return }
        search(value: value)
        searchBar.resignFirstResponder()
    }
}
