//
//  BaseViewController.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigation()
    }

    func customNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.448466301, blue: 0.4682235122, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
