//
//  OtherInformationView.swift
//  TheRestaurants
//
//  Created by PCI0019 on 9/16/20.
//  Copyright © 2020 Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

class OtherInformationView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!

    var viewModel: OtherInformationViewModel? {
        didSet {
            configStackView()
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
        let nib = UINib(nibName: "OtherInformationView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(containerView)
    }

    private func configStackView() {
        guard let viewModel = viewModel else { return }
        for (index, highlight) in viewModel.highlights.enumerated() {
            let hightlightView: HighlightView = HighlightView.loadNib()
            let highlightViewWidth: CGFloat = HighlightView.Config.width * UIScreen.main.bounds.width / 375
            let contentLabelWidth: CGFloat = highlightViewWidth - HighlightView.Config.imageWidth - HighlightView.Config.imageToLabelSpacing
            let contentLabelHeight: CGFloat = highlight.contentHeight(withConstrainedWidth: contentLabelWidth,
                                                                      attributes: [.font: HighlightView.Config.labelFont])
            hightlightView.frame = CGRect(x: 0, y: 0, width: highlightViewWidth, height: contentLabelHeight)
            hightlightView.viewModel = HighlightViewModel(content: highlight)
            if index % 2 == 0 {
                leftStackView.addArrangedSubview(hightlightView)
            } else {
                rightStackView.addArrangedSubview(hightlightView)
            }
        }
    }
}
