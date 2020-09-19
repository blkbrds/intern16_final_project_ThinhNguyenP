//
//  DetailViewController.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private var tabButtons: [UIButton]!
    private var pageController: UIPageViewController!
    private var viewControllers: [UIViewController] = []

    var viewModel: DetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageView()
    }

    @IBAction private func buttonTouchUpInside(_ sender: UIButton) {
        for button in tabButtons {
            button.isSelected = button.tag == sender.tag
        }
        pageController.setViewControllers([viewControllers[sender.tag]], direction: .reverse, animated: false, completion: nil)
    }

    private func setUpPageView() {
        viewControllers = [OverviewViewController(), MenuViewController(), ReviewsViewController()]
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        addChild(pageController)
        contentView.addSubview(self.pageController.view)
        pageController.didMove(toParent: self)
        navigationController?.isNavigationBarHidden = true
    }
}
