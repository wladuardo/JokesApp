//
//  AppDelegate.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 11.01.2023.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let jokesVC = JokesViewController()
    let authVC = AuthorizationViewController()
    let customTabBarController = CustomTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationController()
        FirebaseApp.configure()
        return true
    }
    
    private func setupNavigationController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        customTabBarController.viewControllers = [jokesVC, authVC]
        
        let navigationController = UINavigationController(rootViewController: customTabBarController)
        
        setupTabBarItems()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func setupTabBarItems() {
        let viewControllersArray = [jokesVC, authVC]
        viewControllersArray.enumerated().forEach({ vc in
            vc.element.tabBarItem.image = UIImage(named: "\(vc.offset)")?.withRenderingMode(.alwaysOriginal)
            vc.element.tabBarItem.selectedImage = UIImage(named: "\(vc.offset).selected")?.withRenderingMode(.alwaysOriginal)
        })
        
    }

}

