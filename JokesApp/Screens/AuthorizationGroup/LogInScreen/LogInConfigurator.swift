//
//  LogInConfigurator.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol LogInConfiguratorProtocol {
    func configure(with viewController: LogInViewController)
}

class LogInConfigurator: LogInConfiguratorProtocol {
    func configure(with viewController: LogInViewController) {
        let presenter = LogInPresenter(view: viewController)
        let router = LogInRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
