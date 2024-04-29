//
//  TableHeaderView.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 29.04.2024.
//

import UIKit

// Step 2.
final class TableHeaderView: UIView {

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.width
    }

    // MARK: - Internal

    func configure(with text: String) {
        titleLabel.text = text
    }
}
