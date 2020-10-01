//
//  MenuViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit
protocol MenuViewControllerDelegate: class {

    func viewController(_ viewController: MenuViewController, needPerform action: OverviewViewController.Action)
}
class MenuViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.viewModel = HeaderDetailViewModel(restaurant: viewModel.restaurant)
    }
    
    @IBOutlet private weak var headerView: HeaderDetailView!
    weak var delegate: MenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
    }
    var viewModel = MenuViewModel()
    func updateHeaderView(isFavorite: Bool) {
        viewModel.restaurant.favorite = isFavorite
        if headerView != nil {
            headerView.viewModel = HeaderDetailViewModel(restaurant: viewModel.restaurant)
        }
    }
}
extension MenuViewController: HeaderDetailViewDelegate {
    func view(_ view: HeaderDetailView, needPerforms action: HeaderDetailView.Action) {
        switch action {
        case .back:
            delegate?.viewController(self, needPerform: .back)
        case .favorite(let isFavorite):
            delegate?.viewController(self, needPerform: .favorite(isFavorite: isFavorite))
        }
    }
}
