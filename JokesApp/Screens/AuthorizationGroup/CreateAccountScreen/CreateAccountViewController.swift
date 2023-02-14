//
//  CreateAccountViewController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 01.02.2023.
//

import UIKit
import SnapKit

protocol CreateAccountViewProtocol: AnyObject {
    func setupUI()
}

class CreateAccountViewController: RootAuthorizationController, CreateAccountViewProtocol {
    
    var presenter: CreateAccountPresenterProtocol?
    let configurator: CreateAccountConfiguratorProtocol = CreateAccountConfigurator()
    
    private let mainLabel = UILabel()
    
    private let emailLabel = UILabel()
    private let createPasswordLabel = UILabel()
    private let confirmPasswordLabel = UILabel()
    
    private let emailTextField = UIShowHideTextField(isSecureEnterNeeded: false)
    private let createPasswordTextField = UIShowHideTextField(isSecureEnterNeeded: true)
    private let confirmPasswordTextField = UIShowHideTextField(isSecureEnterNeeded: true)
    
    private let tosLabel = UILabel()
    private let tosCheckmarkButton = UIButton(type: .custom)
    
    private let createAccountButton = CustomProfileButton(type: .system)
    
    private var isTosAccepted: Bool = false
    
    private var email: String?
    private var password: String?
    private var confirmedPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.configureView()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setupMainLabel()
        setupTextFieldLabels()
        setupTermsOfUseButtonAndLabel()
        setupCreateAccountButton()
        setupBottonLabelAndButton()
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            guard let emailText = textField.text else { return }
            guard emailText.contains(where: { $0 == "@" }) else { return }
            email = emailText
        } else if textField == createPasswordTextField {
            guard let passwordText = textField.text else { return }
            password = passwordText
        } else if textField == confirmPasswordTextField {
            guard let confirmedPasswordText = textField.text else { return }
            guard confirmedPasswordText == password else { return }
            confirmedPassword = confirmedPasswordText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

private extension CreateAccountViewController {

    func setupMainLabel() {
        mainLabel.text = "Create account"
        mainLabel.textColor = .black
        mainLabel.font = .systemFont(ofSize: 28, weight: .black)
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints({ label in
            label.leading.equalToSuperview().offset(20)
            label.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        })
    }
    
    func setupBottonLabelAndButton() {
        let label = UILabel()
        label.text = "Already have account?"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        
        [label, button].forEach({ view.addSubview($0) })
        
        button.snp.makeConstraints({ button in
            button.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            button.centerX.equalToSuperview()
        })
        
        label.snp.makeConstraints({ label in
            label.bottom.equalTo(button.snp_topMargin).offset(-10)
            label.centerX.equalToSuperview()
        })
    }
    
    func setupTextFieldLabels() {
        [emailTextField, createPasswordTextField, confirmPasswordTextField].forEach({
            $0.delegate = self
        })

        configurateTextFieldLabels(label: emailLabel,
                                   text: "E-mail", textField: emailTextField,
                                   offsetTo: self.view)
        
        configurateTextFieldLabels(label: createPasswordLabel,
                                   text: "Create a password",
                                   textField: createPasswordTextField,
                                   offsetTo: emailLabel)
        
        configurateTextFieldLabels(label: confirmPasswordLabel,
                                   text: "Create a password",
                                   textField: confirmPasswordTextField,
                                   offsetTo: createPasswordLabel)
        
        configurateTextFields(textField: emailTextField,
                              placeholder: "example@gmail.com",
                              secured: false,
                              label: emailLabel)
        
        configurateTextFields(textField: createPasswordTextField,
                              placeholder: "must be 8 characters",
                              secured: true,
                              label: createPasswordLabel)
        
        configurateTextFields(textField: confirmPasswordTextField,
                              placeholder: "repeat password",
                              secured: true,
                              label: confirmPasswordLabel)
        
    }
    
    func setupCreateAccountButton() {
        updateCreateAccountButton()
        
        createAccountButton.snp.makeConstraints({ button in
            button.top.equalTo(tosLabel.snp_bottomMargin).offset(50)
            button.leading.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.height.equalTo(50)
        })
    }
    
    func updateCreateAccountButton() {
        createAccountButton.isEnabled = isTosAccepted
        switch isTosAccepted {
        case true:
            createAccountButton.configurateButton(text: "Create account",
                                                  textColor: .white,
                                                  backgroundColor: .black,
                                                  needBorder: false,
                                                  action: #selector(createAccountButtonAction),
                                                  showAt: view,
                                                  target: self)
        case false:
            createAccountButton.configurateButton(text: "Create account",
                                                  textColor: .black,
                                                  backgroundColor: .white,
                                                  needBorder: true,
                                                  action: #selector(createAccountButtonAction),
                                                  showAt: view,
                                                  target: self)
        }
    }
    
    func updateCheckmarkButtonOnTap() {
        let selectedImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        let unselectedImage = UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        
        if !isTosAccepted {
            isTosAccepted = true
            UIView.transition(with: tosCheckmarkButton,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { self.tosCheckmarkButton.setImage(selectedImage, for: .normal) },
                              completion: nil)
        } else {
            isTosAccepted = false
            UIView.transition(with: tosCheckmarkButton,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: { self.tosCheckmarkButton.setImage(unselectedImage, for: .normal) },
                              completion: nil)
        }
    }
    
    func setupTermsOfUseButtonAndLabel() {
        tosLabel.text = "I accept the terms of use and privacy policy"
        tosLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        tosCheckmarkButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .normal)
        tosCheckmarkButton.addTarget(self, action: #selector(tosCheckmarkButtonAction), for: .touchUpInside)
        
        [tosLabel, tosCheckmarkButton].forEach({ view.addSubview($0) })
        
        tosCheckmarkButton.snp.makeConstraints({ button in
            button.top.equalTo(confirmPasswordTextField.snp_bottomMargin).offset(50)
            button.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        })
        
        tosLabel.snp.makeConstraints({ label in
            label.centerY.equalTo(tosCheckmarkButton)
            label.leading.equalTo(tosCheckmarkButton).offset(30)
        })
        
    }
}

private extension CreateAccountViewController {

    @objc
    func createAccountButtonAction() {
        guard let unwEmail = email,
              let unwConfirmedPassword = confirmedPassword else { return }
        AuthenticationManager.shared.createUser(email: unwEmail, password: unwConfirmedPassword, completion: {_ in
            print("succes")
        })
    }
    
    @objc
    func logInButtonAction() {
        presenter?.logInButtonAction()
    }
    
    @objc
    func tosCheckmarkButtonAction() {
        updateCheckmarkButtonOnTap()
        updateCreateAccountButton()
    }
}




