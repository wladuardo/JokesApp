//
//  LogInPresenter.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation

protocol LogInPresenterProtocol {
    var router: LogInRouterProtocol? { get set }
    var view: LogInViewProtocol? { get set }
    
    func logInButtonAction()
    func configureView()
}

class LogInPresenter: LogInPresenterProtocol {
    var router: LogInRouterProtocol?
    var view: LogInViewProtocol?
    
    required init(view: LogInViewProtocol) {
        self.view = view
    }
    
    func logInButtonAction() {
    }
    
    func configureView() {
        view?.setupUI()
    }
    
    
}
