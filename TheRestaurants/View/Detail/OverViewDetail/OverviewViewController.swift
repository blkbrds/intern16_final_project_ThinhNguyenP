//
//  DetailOverViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit
protocol OverviewControllerDelegate: class {

    func viewController(_ viewController: OverviewViewController, needPerform action: OverviewViewController.Action)
}

class OverviewViewController: UIViewController {

    enum Action {
        case back
    }

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerView: HeaderDetailView!
    @IBOutlet private weak var mapDetailView: MapDetailView!
    @IBOutlet private weak var informationView: InformationDetailView!
    @IBOutlet private weak var otherInformationView: OtherInformationView!
    weak var delegate: OverviewControllerDelegate?

    var viewModel = OverviewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        getRestaurantDetail()
        headerView.delegate = self
    }

    func getRestaurantDetail() {
        Indicator.start()
        viewModel.getRestaurantDetail { [weak self] (result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case .success:
                this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant,
                                                                  cuisine: this.viewModel.restaurant.cuisines ?? "")
                this.informationView.viewModel = InformationDetailViewModel(restaurant: this.viewModel.restaurant)
                this.mapDetailView.viewModel = MapDetailViewModel(restaurant: this.viewModel.restaurant)
                this.otherInformationView.viewModel = OtherInformationViewModel(highlights: this.viewModel.restaurant.highlights ?? [])
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
}
extension OverviewViewController: HeaderDetailViewDelegate {
    func view(_ view: HeaderDetailView, needPerforms action: HeaderDetailView.Action) {
        switch action {
        case .back:
            delegate?.viewController(self, needPerform: .back)
        }
    }
}
