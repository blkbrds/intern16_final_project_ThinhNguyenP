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

class PopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = PopUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        searchBar.delegate = self
    }

    func configTableView() {
        let nib = UINib(nibName: "PopUpTableViewCell", bundle: .main)
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
        self.dismiss(animated: true, completion: nil)
    }
}
extension PopUpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInsection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? PopUpTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        SceneDelegate.shared.changeRoot(root: .tabbar)
    }
}

extension PopUpViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else { return }
        search(value: value)
        searchBar.resignFirstResponder()
    }
}
