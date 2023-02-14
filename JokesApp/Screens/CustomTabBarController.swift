//
//  CustomTabBarController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 11.01.2023.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private lazy var customTabBar: UITabBar = {
        let tabBar = UITabBar()
        return tabBar
    }()

    private lazy var blurEffect: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.tabBar.bounds
        return blurView
    }()
    
    override func viewDidLoad() {
        self.delegate = self
        customizeTabBar()
    }
    
    private func setupBlurEffect() {
        customTabBar.addSubview(blurEffect)
        blurEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func customizeTabBar() {
        tabBar.addSubview(customTabBar)
        customTabBar.clipsToBounds = true
        customTabBar.layer.cornerRadius = 15
        
        setupBlurEffect()
        customTabBar.snp.makeConstraints({ tabbar in
            tabbar.leading.equalToSuperview().offset(12)
            tabbar.trailing.equalToSuperview().offset(-12)
            tabbar.bottom.equalTo(view.safeAreaLayoutGuide)
            tabbar.height.equalTo(60)
        })
    }

}
