//
//  AlbumCell.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 29.04.2024.
//

import UIKit

// Step 7.
final class AlbumCell: UICollectionViewCell {

    // MARK: - Private Structures

    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2
    }

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Lifecycle

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
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
    }
}
