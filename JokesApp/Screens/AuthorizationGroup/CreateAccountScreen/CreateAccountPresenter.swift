//
//  CreateAccountPresenter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol CreateAccountPresenterProtocol: AnyObject {
    var router: CreateAccountRouterProtocol? { get set }
    var view: CreateAccountViewProtocol? { get set }
    
    func logInButtonAction()
    func configureView()
}

class CreateAccountPresenter: CreateAccountPresenterProtocol {
    
    weak var view: CreateAccountViewProtocol?
    var router: CreateAccountRouterProtocol?
    
    required init(view: CreateAccountViewProtocol) {
        self.view = view
    }
    
    func logInButtonAction() {
        router?.goToLogInScreen()
    }

    func configureView() {
        view?.setupUI()
    }
    
    
}

