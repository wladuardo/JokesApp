//
//  UITextFieldExtention.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 01.02.2023.
//

import Foundation
import UIKit

class UIShowHideTextField: UITextField {
    
    private let rightButton  = UIButton(type: .custom)
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    init(isSecureEnterNeeded: Bool) {
        super.init(frame: .zero)
        commonInit(isSecureEnterNeeded: isSecureEnterNeeded)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(isSecureEnterNeeded: Bool) {
        rightButton.setImage(UIImage(named: "eyeOpened") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        
        if isSecureEnterNeeded {
            rightViewMode = .whileEditing
            rightView = rightButton
            isSecureTextEntry = true
        }
    }
    
    private func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            UIView.transition(with: rightButton,
                              duration: 0.35,
                              options: .transitionFlipFromBottom,
                              animations: { self.rightButton.setImage(UIImage(named: "eyeOpened"),
                                                                      for: .normal) },
                              completion: nil)
        } else {
            UIView.transition(with: rightButton,
                              duration: 0.35,
                              options: .transitionFlipFromBottom,
                              animations: { self.rightButton.setImage(UIImage(named: "eyeClosed"),
                                                                      for: .normal) },
                              completion: nil)
        }
    }
    
    @objc
    private func toggleShowHide(button: UIButton) {
        toggle()
    }
    
}

extension UIShowHideTextField {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = 5
        let width  = 40
        let height = width
        let x = Int(bounds.width) - width - offset
        let y = offset
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
}
