//
//  IntroduceViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class IntroduceViewController: BaseViewController {

    @IBAction private func chooseCityButtonTouchUpInside(_ sender: Any) {
        let vc = SearchCityPopUpViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
}
extension IntroduceViewController: SearchCityPopUpViewControllerDelegate {
    func view(_ view: SearchCityPopUpViewController, needPerform action: SearchCityPopUpViewController.Action) {
         SceneDelegate.shared.changeRoot(root: .tabbar)
    }
}
