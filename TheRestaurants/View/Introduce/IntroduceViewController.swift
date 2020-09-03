//
//  IntroduceViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class IntroduceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseCityButtonTouchUpInside(_ sender: Any) {
        let vc = PopUpViewController()
        self.present(vc, animated: true)
    }
}
