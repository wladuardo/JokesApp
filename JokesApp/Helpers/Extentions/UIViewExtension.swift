//
//  UIViewExtension.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 09.02.2023.
//

import Foundation
import UIKit

extension UIView {
    func applyCustomViewStyle(color: UIColor = .black, shadowColor: UIColor = .black,
                              cornerRadius: CGFloat = 20) {
        self.clipsToBounds = true
        self.backgroundColor = color
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
    }
}
