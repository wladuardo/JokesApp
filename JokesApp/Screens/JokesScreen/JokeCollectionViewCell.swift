//
//  JokeCollectionViewCell.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 12.01.2023.
//

import UIKit
import SnapKit

class JokeCollectionViewCell: UICollectionViewCell {
    static let identifier = "jokeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeCell() {
        contentView.applyCustomViewStyle(color: .green)
    }
}
