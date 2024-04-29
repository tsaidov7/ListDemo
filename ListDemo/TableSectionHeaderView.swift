//
//  TableSectionHeaderView.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

// Step 3.
final class TableSectionHeaderView: UITableViewHeaderFooterView {

    // MARK: - Private Structures

    private enum Constants {
        static let xInset: CGFloat = 20
        static let yInset: CGFloat = 10
        static let numberOfLines = 0
    }

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.numberOfLines
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    func configure(with text: String) {
        titleLabel.text = text
    }

    // MARK: - Private

    private func setup() {
        contentView.addSubview(titleLabel)
        let verticalConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.yInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.yInset)
        ]
        let horizontalConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.xInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.xInset)
        ]
        // Does not play well with Autolayout.
        // https://samwize.com/2015/11/06/guide-to-customizing-uitableview-section-header-footer/
        verticalConstraints.forEach {
            $0.priority = UILayoutPriority(999)
        }
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
    }
}
