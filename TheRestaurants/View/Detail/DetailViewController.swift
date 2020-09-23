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
    @IBOutlet private weak var tabButtonsView: UIView!
    @IBOutlet private var tabButtons: [UIButton]!
    private var pageController: UIPageViewController!
    private var viewControllers: [UIViewController] = []
    private var lineView: UIView!

    var viewModel: DetailViewModel!
    var overView = OverviewViewController()
    var menuView = MenuViewController()
    var review = ReviewsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setUpPageView()
        configLineView()
    }

    @IBAction private func buttonTouchUpInside(_ sender: UIButton) {
        for button in tabButtons {
            button.isSelected = button.tag == sender.tag
        }
        pageController.setViewControllers([viewControllers[sender.tag]], direction: .reverse, animated: false, completion: nil)
        configLineViewWithAnimation(selectedButtonTag: sender.tag)
    }

    private func setUpPageView() {
        guard let id = viewModel?.id else { return }
        overView.viewModel = OverviewViewModel(id: id)
        viewControllers = [overView, MenuViewController(), ReviewsViewController()]
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        addChild(pageController)
        contentView.addSubview(self.pageController.view)
        pageController.didMove(toParent: self)
    }

    private func configLineView() {
        let frame = CGRect(x: 0,
                           y: tabButtonsView.frame.minY,
                           width: tabButtonsView.frame.width / 3,
                           height: 3)
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = #colorLiteral(red: 0, green: 0.3764705882, blue: 0.3921568627, alpha: 1)
        self.lineView = lineView

        view.addSubview(lineView)
        view.bringSubviewToFront(lineView)
    }

    private func configLineViewWithAnimation(selectedButtonTag: Int) {
        UIView.animate(withDuration: 0.5) {
            let newX: CGFloat = self.tabButtonsView.frame.width / 3 * CGFloat(selectedButtonTag)
            self.lineView.frame = CGRect(x: newX,
                                         y: self.lineView.frame.minY,
                                         width: self.lineView.frame.width,
                                         height: self.lineView.frame.height)
        }
    }
}
