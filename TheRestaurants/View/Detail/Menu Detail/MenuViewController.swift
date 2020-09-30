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

    enum Action {
        case back
    }
    @IBOutlet private weak var headerView: HeaderDetailView!
    weak var delegate: MenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
//        headerView.delegate = self
    }
    var viewModel = MenuViewModel()
}
//extension MenuViewController: HeaderDetailViewDelegate {
//    func view(_ view: HeaderDetailView, id: String, needPerforms action: HeaderDetailView.Action) {
//        switch action {
//        case .back:
//            
//        default:
//            <#code#>
//        }
//    }
//    
//    
//}
