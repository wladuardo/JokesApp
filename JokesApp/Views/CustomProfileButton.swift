//
//  CustomProfileButton.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 01.02.2023.
//

import Foundation
import UIKit

class CustomProfileButton: UIButton {
    
    func configurateButton(text: String,
                           textColor: UIColor,
                           backgroundColor: UIColor,
                           needBorder: Bool,
                           action: Selector,
                           showAt view: UIView,
                           target: UIViewController) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.addTarget(target, action: action, for: .touchUpInside)
        
        if needBorder {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        }
        
        view.addSubview(self)
    }
}
