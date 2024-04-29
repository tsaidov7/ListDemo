//
//  MultilineCell.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 30.04.2024.
//

import UIKit

// Step 9.
final class MultilineCell: UITableViewCell {

    // MARK: - Private Properties

    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Internal
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
