//
//  CustomTableViewCell.swift
//  UITableViewDemo
//
//  Created by Timur Saidov on 02.05.2024.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        print("🍑 CustomTableViewCell", bounds.size, sizeThatFits(.init(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)), systemLayoutSizeFitting(.init(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)))
    }

    // MARK: - Internal

    func setup(withText title: String) {
        titleLabel.text = title
    }

    // MARK: - Private

    private func setupContentView() {
        contentView.addSubview(titleLabel)

        let bottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .init(999)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bottomConstraint
        ])
    }
}
