//
//  IntroduceViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class IntroduceViewController: BaseViewController {

    @IBAction func chooseCityButtonTouchUpInside(_ sender: Any) {
        let vc = SearchCityPopUpViewController()
        present(vc, animated: true)
    }
}
