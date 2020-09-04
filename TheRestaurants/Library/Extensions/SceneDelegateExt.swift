//
//  AppDelegateExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/4/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

extension SceneDelegate {

    func findCurrentViewController() -> UIViewController? {
        let rootViewController = SceneDelegate.shared.window?.rootViewController
        return findCurrentViewController(byTempTopViewController: rootViewController)
    }

    func findCurrentViewController(byTempTopViewController vc: UIViewController?) -> UIViewController? {
        guard let presentedViewController = vc?.presentedViewController else { return vc }

        if presentedViewController is UINavigationController {
            let nav = presentedViewController
            let topViewController = nav.children.last
            return findCurrentViewController(byTempTopViewController: topViewController)
        }

        return findCurrentViewController(byTempTopViewController: presentedViewController)
    }
}
