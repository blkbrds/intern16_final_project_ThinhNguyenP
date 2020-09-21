//
//  DetailOverViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/13/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet private weak var headerView: HeaderDetailView!
    @IBOutlet private weak var mapDetailView: MapDetailView!
    @IBOutlet private weak var informationView: InformationDetailView!
    @IBOutlet private weak var otherInformationView: OtherInformationView!
    
    var viewModel = OverviewViewModel() {
        didSet {
            print(viewModel.id)
             loadAPI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadAPI()
    }
    
    
    func loadAPI() {
        Indicator.start()
        viewModel.loadData { [weak self] (result) in
            Indicator.stop()
            guard let this = self else { return }
            switch result {
            case .success:
                print("sssss")
                this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
//                headerView.viewModel?.restaurant = viewModel.restaurant
//                headerView.viewModel?.restaurant = viewModel
//                HeaderDetailViewModel(restaurant: viewModel.restaurant ?? )
//                this.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
//                this.headerView = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
//                this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
//                this.mapDetailView.viewModel = MapDetailViewModel(restaurant: this.viewModel.restaurant)
//                this.informationView.viewModel = InformationDetailViewModel(restaurant: this.viewModel.restaurant)
            case .failure(let error):
                this.alert(error: error)
            }
        }
    }
//        private func loadAPI() {
//            Indicator.start()
//            viewModel.loadData(id: <#T##String#>, completion: <#T##APICompletion##APICompletion##(APIResult) -> Void#>)
//            viewModel.loadData(id: DetailViewModel.init(restaurant: )) { [weak self ](result) in
//                Indicator.stop()
//                guard let this = self else { return }
//                switch result {
//                case .success:
//                    this.headerView.viewModel = HeaderDetailViewModel(restaurant: this.viewModel.restaurant)
//                    this.mapDetailView.viewModel = MapDetailViewModel(restaurant: this.viewModel.restaurant)
//                    this.informationView.viewModel = InformationDetailViewModel(restaurant: this.viewModel.restaurant)
//                case .failure(let error):
//                    this.alert(error: error)
//                }
//            }
//        }
}
