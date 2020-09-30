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
        case favorite(isFavorite: Bool)
    }
    
    @IBOutlet private weak var headerView: HeaderDetailView!
    @IBOutlet private weak var mapDetailView: MapDetailView!
    @IBOutlet private weak var informationView: InformationDetailView!
    @IBOutlet private weak var otherInformationView: OtherInformationView!
    weak var delegate: OverviewControllerDelegate?
    
    var viewModel = OverviewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
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
                this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant, cuisine: this.viewModel.restaurant.cuisines ?? "")
                this.headerView.delegate = self
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
        case .favorite(let isFavorite):
            delegate?.viewController(self, needPerform: .favorite(isFavorite: isFavorite))
        }
    }
    
//    func view(_ view: HeaderDetailView, id: String, needPerforms action: HeaderDetailView.Action) {
//        switch action {
//        case .back:
//            delegate?.viewController(self, needPerform: .back)
//        case .favorite(let isFavorite):
//            if isFavorite {
//                viewModel.unFavorite(id: id) { [weak self] result in
//                    guard let this = self else { return }
//                    switch result {
//                    case .success:
//                        this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant, cuisine: this.viewModel.restaurant.cuisines ?? "")
//                    case.failure(let error):
//                        this.alert(error: error)
//                    }
//                }
//            } else {
//                viewModel.addFavorite(id: id) { [weak self] result in
//                    guard let this = self else { return }
//                    switch result {
//                    case .success:
//                        this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant, cuisine: this.viewModel.restaurant.cuisines ?? "")
//                    case .failure(let error):
//                        this.alert(error: error)
//                    }
//                }
//            }
//        }
//    }
}
