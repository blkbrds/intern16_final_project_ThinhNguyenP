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
    var overviewViewController: OverviewViewController?
    var reviewViewController: ReviewsViewController?
    var menuViewController: MenuViewController?

    var viewModel: DetailViewModel?
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
        guard let restaurant = viewModel?.usedRestaurant else { return }
        overviewViewController = OverviewViewController()
        overviewViewController?.delegate = self
        overviewViewController?.viewModel = OverviewViewModel(restaurant: restaurant)
        menuViewController = MenuViewController()
        menuViewController?.delegate = self
        menuViewController?.viewModel = MenuViewModel(restaurant: restaurant)
        reviewViewController = ReviewsViewController()
        reviewViewController?.delegate = self
        reviewViewController?.viewModel = ReviewViewModel(restaurant: restaurant)
        if let overviewViewController = overviewViewController,
            let menuViewController = menuViewController,
            let reviewViewController = reviewViewController {
            viewControllers = [overviewViewController, menuViewController, reviewViewController]
        }
        // Setup page view
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: false, completion: nil)
        addChild(pageController)
        contentView.addSubview(self.pageController.view)
        pageController.didMove(toParent: self)
        navigationController?.isNavigationBarHidden = true
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

    private func updateHeaderViewInViewController(isFavorite: Bool) {
        overviewViewController?.updateHeaderView(isFavorite: isFavorite)
        reviewViewController?.updateHeaderView(isFavorite: isFavorite)
        menuViewController?.updateHeaderView(isFavorite: isFavorite)
    }

    private func handleViewControllerAction(action: OverviewViewController.Action) {
        guard let viewModel = viewModel else { return }
        switch action {
        case .back:
            navigationController?.popViewController(animated: true)
        case .favorite(let isFavorite):
            if isFavorite {
                viewModel.unfavoriteItem { [weak self](result) in
                    guard let this = self else { return }
                    switch result {
                    case.success:
                        this.updateHeaderViewInViewController(isFavorite: false)
                    case .failure(let error):
                        this.alert(error: error)
                    }
                }
            } else {
                viewModel.addFavoriteItem {[weak self] (result) in
                    guard let this = self else { return }
                    switch result {
                    case.success:
                        this.updateHeaderViewInViewController(isFavorite: true)
                    case.failure(let error):
                        this.alert(error: error)
                    }
                }
            }
        }
    }
}

extension DetailViewController: OverviewControllerDelegate {
    func viewController(_ viewController: OverviewViewController, needPerform action: OverviewViewController.Action) {
        handleViewControllerAction(action: action)
    }
}

extension DetailViewController: MenuViewControllerDelegate {
    func viewController(_ viewController: MenuViewController, needPerform action: OverviewViewController.Action) {
        handleViewControllerAction(action: action)
    }
}
extension DetailViewController: ReviewsViewControllerDelegate {
    func view(_ viewController: ReviewsViewController, needPerform action: OverviewViewController.Action) {
        handleViewControllerAction(action: action)
    }
}
