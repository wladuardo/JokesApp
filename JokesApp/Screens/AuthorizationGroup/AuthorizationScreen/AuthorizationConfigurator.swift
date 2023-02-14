//
//  AuthorizationConfigurator.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol AuthorizationConfiguratorProtocol {
    func configure(with viewController: AuthorizationViewController)
}

class AuthorizationConfigurator: AuthorizationConfiguratorProtocol {
    func configure(with viewController: AuthorizationViewController) {
        let presenter = AuthorizationPresenter(view: viewController)
        let router = AuthorizationRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
