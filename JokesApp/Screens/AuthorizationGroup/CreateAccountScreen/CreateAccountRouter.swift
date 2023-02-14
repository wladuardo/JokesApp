//
//  CreateAccountRouter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol CreateAccountRouterProtocol {
    func goToLogInScreen()
}

class CreateAccountRouter: CreateAccountRouterProtocol {
    
    weak var viewController: CreateAccountViewController?
    
    init(viewController: CreateAccountViewController) {
        self.viewController = viewController
    }
    
    func goToLogInScreen() {
        let targetVC = LogInViewController()
        viewController?.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}
