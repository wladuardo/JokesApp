//
//  AuthorizationRouter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 07.02.2023.
//

import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    func goToSignInScreen()
    func goToCreateAccountScreen()
}

class AuthorizationRouter: AuthorizationRouterProtocol {
    
    weak var viewController: AuthorizationViewController?
    
    init(viewController: AuthorizationViewController) {
        self.viewController = viewController
    }
    
    func goToSignInScreen() {
        let targetVC = LogInViewController()
        viewController?.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func goToCreateAccountScreen() {
        let targetVC = CreateAccountViewController()
        viewController?.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
}
