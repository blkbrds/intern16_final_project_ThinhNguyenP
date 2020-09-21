//
//  ReviewsViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = ReviewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        let cell = UINib(nibName: "ReviewCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "cellReview")
        tableView.dataSource = self
    }
}
extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReview", for: indexPath) as? ReviewCell else { return UITableViewCell() }
        return cell
    }
}
