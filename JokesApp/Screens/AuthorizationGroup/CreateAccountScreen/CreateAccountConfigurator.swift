//
//  CreateAccountConfigurator.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol CreateAccountConfiguratorProtocol {
    func configure(with viewController: CreateAccountViewController)
}

class CreateAccountConfigurator: CreateAccountConfiguratorProtocol {
    func configure(with viewController: CreateAccountViewController) {
        let presenter = CreateAccountPresenter(view: viewController)
        let router = CreateAccountRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
