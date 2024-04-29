//
//  AlbumCell.swift
//  ListDemo
//
//  Created by Timur Saidov on 26.04.2024.
//

import UIKit

// Step 7.
final class AlbumCell: UICollectionViewCell {

    // MARK: - Private Structures

    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2
        static let sideInset: CGFloat = 20
    }

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    func configure(wth text: String) {
        titleLabel.text = text
    }

    // MARK: - Private

    private func setup() {
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
}
