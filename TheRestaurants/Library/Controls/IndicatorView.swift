//
//  IndicatorView.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/4/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

typealias Indicator = IndicatorView

final class IndicatorView: UIView {

    static let shared: IndicatorView = {
        let view = IndicatorView(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        return view
    }()

    private var indicatorView: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView.center = center
        loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let indicatorView = UIActivityIndicatorView()
        indicatorView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        indicatorView.style = .large
        indicatorView.center = CGPoint(x: loadingView.frame.width / 2, y: loadingView.frame.height / 2)
        self.indicatorView = indicatorView

        loadingView.addSubview(indicatorView)
        addSubview(loadingView)
    }

    static func start() {
        let rootView = SceneDelegate.shared.findCurrentViewController()?.view
        rootView?.addSubview(shared)
        rootView?.bringSubviewToFront(shared)
        shared.indicatorView?.startAnimating()
    }

    static func stop() {
        shared.removeFromSuperview()
    }
}
