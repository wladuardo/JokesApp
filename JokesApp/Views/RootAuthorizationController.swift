//
//  CustomNavigationController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 07.02.2023.
//

import UIKit

class RootAuthorizationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavigationBar()
    }
    
    func configurateNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navigationBack")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonAction))
        
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    func configurateTextFields(textField: UITextField, placeholder: String,
                               secured: Bool, label: UILabel) {
        textField.placeholder = placeholder
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints({ textField in
            textField.top.equalTo(label.snp_bottomMargin).offset(10)
            textField.leading.equalTo(label)
            textField.trailing.equalToSuperview().offset(-20)
            textField.height.equalTo(50)
        })
    }
    
    func configurateTextFieldLabels(label: UILabel, text: String,
                                    textField: UITextField, offsetTo view: UIView) {
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        self.view.addSubview(label)
        
        label.snp.makeConstraints({ label in
            label.leading.equalToSuperview().offset(20)
            label.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        })
    }
    
    @objc
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }

}
