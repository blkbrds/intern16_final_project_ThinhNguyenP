//
//  UIViewExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/10/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

extension UIView {
    public class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    public class func loadNib<T: UIView>() -> T {
        let name = String(describing: self)
        let bundle = Bundle(for: T.self)
        guard let xib = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
            fatalError("Cannot load nib named \(name)")
        }
        return xib
    }
}
