//
//  AuthorizationViewController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 11.01.2023.
//

import UIKit
import SnapKit

protocol AuthorizationViewProtocol: AnyObject {
    func setupUI()
}

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {

    var presenter: AuthorizationPresenterProtocol?
    let configurator: AuthorizationConfiguratorProtocol = AuthorizationConfigurator()
    
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let signInButton = CustomProfileButton(type: .system)
    private let createAccountButton = CustomProfileButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setupButtons()
        setupLabels()
    }
}

private extension AuthorizationViewController {
    
    func setupLabels() {
        mainLabel.text = "Explore the app"
        mainLabel.font = .systemFont(ofSize: 28, weight: .black)
        mainLabel.textColor = .black
        view.addSubview(mainLabel)
        
        subLabel.text = "You can joke your jokes in one app. Get reactions and have fun"
        subLabel.font = .systemFont(ofSize: 18, weight: .light)
        subLabel.numberOfLines = 0
        subLabel.textColor = .black
        view.addSubview(subLabel)
        
        mainLabel.snp.makeConstraints({ label in
            label.bottom.equalTo(subLabel.snp_topMargin).offset(-20)
            label.trailing.equalToSuperview().offset(20)
            label.leading.equalToSuperview().offset(20)
        })
        
        subLabel.snp.makeConstraints({ label in
            label.bottom.equalTo(signInButton.snp_topMargin).offset(-50)
            label.trailing.equalToSuperview().offset(-20)
            label.leading.equalToSuperview().offset(20)
        })
    }
    
    func setupButtons() {
        signInButton.configurateButton(text: "Sign In",
                                       textColor: .white,
                                       backgroundColor: .black,
                                       needBorder: false,
                                       action: #selector(signInButtonAction),
                                       showAt: view, target: self)
        
        createAccountButton.configurateButton(text: "Create Account",
                                              textColor: .black,
                                              backgroundColor: .white,
                                              needBorder: true,
                                              action: #selector(createAccountButtonAction),
                                              showAt: view,
                                              target: self)
        
        createAccountButton.snp.makeConstraints({ button in
            button.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            button.leading.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.height.equalTo(50)
        })
        
        signInButton.snp.makeConstraints({ button in
            button.bottom.equalTo(createAccountButton.snp_topMargin).offset(-20)
            button.leading.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.height.equalTo(50)
        })
    }
}

private extension AuthorizationViewController {
    
    @objc
    func signInButtonAction() {
        presenter?.signInButtonAction()
    }
    
    @objc
    func createAccountButtonAction() {
        presenter?.createAccountButtonAction()
    }
}
