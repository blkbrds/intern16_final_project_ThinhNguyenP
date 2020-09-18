//
//  UIImageViewExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/10/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    func setImage(url: String?, placeholderImage: UIImage? = nil) {
        guard let urlStr = url, let url = URL(string: urlStr) else {
            self.image = placeholderImage
            return
        }
        self.kf.setImage(with: url)
    }
}
