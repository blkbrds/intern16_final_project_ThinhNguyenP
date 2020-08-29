//
//  SceneDelegate.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import SwiftUI
import SVProgressHUD
typealias HUD = SVProgressHUD

enum RootViewController {
    case introdude
    case tabbar
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    static var shared: SceneDelegate {
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("Can not case scene delegate")
        }
        return scene
    }

    func changeRoot(root: RootViewController) {
        window?.rootViewController = setupTabbar()
        window?.makeKeyAndVisible()
    }
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowSence)
        let navi = UINavigationController(rootViewController: IntroduceViewController())
        window.rootViewController = navi
        self.window = window
        window.makeKeyAndVisible()
    }

    func setupTabbar() -> UITabBarController {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let home = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: home)
        homeNavi.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_tabbar_home"), tag: 0)
        let map = MapViewController()
        let mapNavi = UINavigationController(rootViewController: map)
        mapNavi.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_tabbar_map"), tag: 1)
        let favorite = FavoriteViewController()
        let favoriteNavi = UINavigationController(rootViewController: favorite)
        favoriteNavi.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_tabbar_favorite"), tag: 2)
        let search = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: search)
        searchNavi.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_tabbar_search"), tag: 3)
        let tabbarController = UITabBarController()
        tabbarController.tabBar.tintColor = #colorLiteral(red: 0, green: 0.3764705882, blue: 0.3921568627, alpha: 1)
        tabbarController.tabBar.standardAppearance = appearance
        tabbarController.viewControllers = [homeNavi, mapNavi, favoriteNavi, searchNavi]
        return tabbarController
    }
}
