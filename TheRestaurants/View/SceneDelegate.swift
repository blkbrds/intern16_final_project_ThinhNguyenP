//
//  SceneDelegate.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit
import SwiftUI
import RealmSwift

enum RootViewController {
    case introduce
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
        switch root {
        case .introduce:
            window?.rootViewController = IntroduceViewController()
        case .tabbar:
            window?.rootViewController = setupTabbar()
        }
        window?.makeKeyAndVisible()
    }

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowSence = (scene as? UIWindowScene) else { return }
//        configureRealm()
        let window = UIWindow(windowScene: windowSence)
        self.window = window
        if Session.cityId == nil {
            changeRoot(root: .introduce)
        } else {
            changeRoot(root: .tabbar)
        }
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

//    func configureRealm() {
//        // Inside your application(application:didFinishLaunchingWithOptions:)
////        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
////            let realmURLs: [URL] = [
////                realmURL,
////                realmURL.appendingPathExtension("lock"),
////                realmURL.appendingPathExtension("note"),
////                realmURL.appendingPathExtension("management")
////            ]
////            for URL in realmURLs {
////                do {
////                    try FileManager.default.removeItem(at: URL)
////                } catch {
////                    // handle error
////                }
////            }
////        }
//        do {
//            let realm = try Realm()
//            print("== 0", realm.configuration.fileURL)
//        } catch {
//
//        }
//
//
//        let config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 1,
//
//            // Set the block which will be called automatically when opening a Realm with
//            // a schema version lower than the one set above
//            migrationBlock: { migration, oldSchemaVersion in
//                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion < 1) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//            })
//
//        // Tell Realm to use this new configuration object for the default Realm
//        Realm.Configuration.defaultConfiguration = config
//
//    }
}
