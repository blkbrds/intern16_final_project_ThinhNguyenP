//
//  UIViewExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/10/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

extension UIView {
    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
