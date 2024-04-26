//
//  TableSectionHeaderView.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

// Step 3.
class TableSectionHeaderView: UITableViewHeaderFooterView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with text: String) {
        titleLabel.text = text
    }
}
