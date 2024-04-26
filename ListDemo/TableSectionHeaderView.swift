//
//  TableSectionHeaderView.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

// Step 3.
class TableSectionHeaderView: UITableViewHeaderFooterView {

    private enum Constants {
        static let xInset: CGFloat = 20
        static let yInset: CGFloat = 10
        static let numberOfLines = 0
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLines
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.yInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.xInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.xInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.yInset),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with text: String) {
        titleLabel.text = text
    }
}
