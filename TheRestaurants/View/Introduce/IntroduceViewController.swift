//
//  IntroduceViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

class IntroduceViewController: UIViewController {

    var popUpWindow = PopUpViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseCityButtonTouchUpInside(_ sender: Any) {
        popUpWindow.view.frame = CGRect(x: 0, y: 220, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        popUpWindow.modalPresentationStyle = .fullScreen
        popUpWindow.modalTransitionStyle = .coverVertical
        self.present(popUpWindow, animated: true)

    }
}
