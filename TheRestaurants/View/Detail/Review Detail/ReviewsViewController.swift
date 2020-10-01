//
//  ReviewsViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

protocol ReviewsViewControllerDelegate: class {
    func view(_ viewController: ReviewsViewController, needPerform action: OverviewViewController.Action)
}
class ReviewsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reviewCountLabel: UILabel!
    @IBOutlet private weak var headerView: HeaderDetailView!
    weak var delegate: ReviewsViewControllerDelegate?
    var viewModel = ReviewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadReview()
        headerView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        headerView.viewModel = HeaderDetailViewModel(restaurant: viewModel.restaurant)
    }

    private func configTableView() {
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
                this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
                this.headerView.delegate = self
                this.reviewCountLabel.text = "- \(this.viewModel.restaurant.review ?? 0) Reviews"
                this.ratingLabel.text = "\(this.viewModel.restaurant.rating ?? "0")"
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }

    func updateHeaderView(isFavorite: Bool) {
        viewModel.restaurant.favorite = isFavorite
        if headerView != nil {
            headerView.viewModel = HeaderDetailViewModel(restaurant: viewModel.restaurant)
        }
    }
}
extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellReview", for: indexPath) as? ReviewCell
            else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCellAt(indexPath: indexPath)
        return cell
    }
}
extension ReviewsViewController: HeaderDetailViewDelegate {
    func view(_ view: HeaderDetailView, needPerforms action: HeaderDetailView.Action) {
        switch action {
        case .back:
            delegate?.view(self, needPerform: .back)
        case .favorite(let isFavorite):
            delegate?.view(self, needPerform: .favorite(isFavorite: isFavorite))
        }
    }
}
