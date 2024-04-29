//
//  TableSectionHeaderView.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 29.04.2024.
//

import UIKit

// Step 3.
final class TableSectionHeaderView: UITableViewHeaderFooterView {

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!

    // MARK: - Internal
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
