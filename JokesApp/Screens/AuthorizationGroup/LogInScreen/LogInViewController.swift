//
//  SignInViewController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 07.02.2023.
//

import UIKit

protocol LogInViewProtocol {
    func setupUI()
}

class LogInViewController: RootAuthorizationController, UITextFieldDelegate, LogInViewProtocol {
    
    var presenter: LogInPresenterProtocol?
    let configurator: LogInConfiguratorProtocol = LogInConfigurator()
    
    private let mainLabel = UILabel()
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    
    private let emailTextField = UIShowHideTextField(isSecureEnterNeeded: false)
    private let passwordTextField = UIShowHideTextField(isSecureEnterNeeded: true)
    
    private let logInButton = CustomProfileButton(type: .system)
    private let forgotPasswordButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setupMainLabel()
        setupTextFieldLabels()
        setupForgotPasswordButton()
        setupLogInButton()
    }
}

private extension LogInViewController {
    func setupMainLabel() {
        mainLabel.text = "Hi, Welcome!👋"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 28, weight: .black)
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints({ label in
            label.leading.equalToSuperview().offset(20)
            label.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        })
    }
    
    func setupTextFieldLabels() {
        [emailTextField, passwordTextField].forEach({
            $0.delegate = self
        })

        configurateTextFieldLabels(label: emailLabel,
                                   text: "E-mail", textField: emailTextField,
                                   offsetTo: self.view)
        
        configurateTextFieldLabels(label: passwordLabel,
                                   text: "Create a password",
                                   textField: passwordTextField,
                                   offsetTo: emailLabel)
        
        configurateTextFields(textField: emailTextField,
                              placeholder: "Enter your E-mail",
                              secured: false,
                              label: emailLabel)
        
        configurateTextFields(textField: passwordTextField,
                              placeholder: "Enter your password",
                              secured: true,
                              label: passwordLabel)
    }
    
    func setupLogInButton() {
        logInButton.configurateButton(text: "Log In",
                                              textColor: .white,
                                              backgroundColor: .black,
                                              needBorder: false,
                                              action: #selector(logInButtonAction),
                                              showAt: view,
                                              target: self)
        
        logInButton.snp.makeConstraints({ button in
            button.top.equalTo(forgotPasswordButton.snp_bottomMargin).offset(40)
            button.leading.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.height.equalTo(50)
        })
    }
    
    func setupForgotPasswordButton() {
        forgotPasswordButton.setTitle("Forgot password?", for: .normal)
        forgotPasswordButton.setTitleColor(.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        forgotPasswordButton.addTarget(self,
                                       action: #selector(forgotPasswordButtonAction),
                                       for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints({ button in
            button.top.equalTo(passwordTextField.snp_bottomMargin).offset(16)
            button.trailing.equalToSuperview().offset(-20)
        })
    }
    
    @objc
    func logInButtonAction() {
        presenter?.logInButtonAction()
    }
    
    @objc
    func forgotPasswordButtonAction() {
        print("hi")
    }
}
