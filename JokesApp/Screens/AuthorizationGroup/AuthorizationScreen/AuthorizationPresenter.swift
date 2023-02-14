//
//  AuthorizationPresenter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 07.02.2023.
//

import Foundation

protocol AuthorizationPresenterProtocol: AnyObject {
    var router: AuthorizationRouterProtocol? { get set }
    var view: AuthorizationViewProtocol? { get set }
    
    func createAccountButtonAction()
    func signInButtonAction()
    func configureView()
}

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    weak var view: AuthorizationViewProtocol?
    var router: AuthorizationRouterProtocol?
    
    required init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    func createAccountButtonAction() {
        router?.goToCreateAccountScreen()
    }
    
    func signInButtonAction() {
        router?.goToSignInScreen()
    }
    
    func configureView() {
        view?.setupUI()
    }
    
    
}

