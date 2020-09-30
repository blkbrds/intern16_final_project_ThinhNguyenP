//
//  HightlightView.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/18/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

final class HighlightView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet private weak var contentLabel: UILabel!

    var viewModel: HighlightViewModel? {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }

    func xibSetup() {
        let nib = UINib(nibName: "HighlightView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
        containerView.fillToSuperview()
    }

    private func updateUI() {
        contentLabel.text = viewModel?.content
    }
}
