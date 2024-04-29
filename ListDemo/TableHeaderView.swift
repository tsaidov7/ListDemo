//
//  TableHeaderView.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

// Step 2.
final class TableHeaderView: UIView {

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
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

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.width
    }

    // MARK: - Internal

    func configure(with text: String) {
        titleLabel.text = text
    }

    // MARK: - Private

    private func setup() {
        addSubview(titleLabel)
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        // Does not play well with Autolayout.
        // https://samwize.com/2015/11/06/guide-to-customizing-uitableview-section-header-footer/
        constraints.forEach {
            $0.priority = UILayoutPriority(999)
        }
        NSLayoutConstraint.activate(constraints)
    }
}
