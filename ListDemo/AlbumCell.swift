//
//  AlbumCell.swift
//  ListDemo
//
//  Created by Timur Saidov on 26.04.2024.
//

import UIKit

// Step 7.
class AlbumCell: UICollectionViewCell {

    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2
        static let sideInset: CGFloat = 20
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.purple.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sideInset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(wth text: String) {
        titleLabel.text = text
    }
}
