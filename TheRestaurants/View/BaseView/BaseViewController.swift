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
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0, green: 0.5137254902, blue: 0.5607843137, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
