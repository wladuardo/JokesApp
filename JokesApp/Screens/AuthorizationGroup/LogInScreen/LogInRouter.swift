//
//  LogInRouter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol LogInRouterProtocol {
    func goToProfileScreen()
}

class LogInRouter: LogInRouterProtocol {
    weak var viewController: LogInViewController?
    
    init(viewController: LogInViewController) {
        self.viewController = viewController
    }
    
    func goToProfileScreen() {
        print("profile")
    }
}
