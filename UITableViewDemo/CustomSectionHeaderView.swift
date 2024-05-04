//
//  CustomSectionHeaderView.swift
//  UITableViewDemo
//
//  Created by Timur Saidov on 02.05.2024.
//

import UIKit

final class CustomSectionHeaderView: UITableViewHeaderFooterView {

    // MARK: - Private Properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Lifecycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupSelf() {
        addSubview(imageView)

        let heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.25)
        heightConstraint.priority = UILayoutPriority(999)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightConstraint
        ])
    }
}
