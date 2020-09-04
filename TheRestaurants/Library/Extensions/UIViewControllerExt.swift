//
//  UIViewControllerExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/4/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(error: Error) {
        let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: App.String.ok, style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
