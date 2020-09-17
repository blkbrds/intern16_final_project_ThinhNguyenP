//
//  ReviewsViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!

    var viewModel = ReviewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadReview()
    }

    func configTableView() {
        let cell = UINib(nibName: "ReviewCell", bundle: .main)
        tableView.register(cell, forCellReuseIdentifier: "cellReview")
        tableView.dataSource = self
    }

    func loadReview() {
        Indicator.start()
        viewModel.loadReview { [weak self](result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
                this.reviewCountLabel.text = "\(this.viewModel.reviewsCount) Reviews"
                this.ratingLabel.text = "\(this.viewModel.ratingCount)"
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}
extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReview", for: indexPath) as? ReviewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
}
