//
//  MenuViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var headerView: HeaderDetailView!
    var viewModel = MenuViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadMenu()
    }
    private func configTableView() {
        let cell = UINib(nibName: "MenuCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "cellMenu")
        tableView.dataSource = self
    }

    func loadMenu() {
        Indicator.start()
        viewModel.getDailyMenuDetail { [weak self](result) in
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
}
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as? MenuCell else { return UITableViewCell()}
        cell.viewModel = viewModel.viewModelForCellAt(indexPath: indexPath)
        return cell
    }
}
