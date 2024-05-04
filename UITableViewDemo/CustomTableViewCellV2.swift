//
//  CustomTableViewCellV2.swift
//  UITableViewDemo
//
//  Created by Timur Saidov on 02.05.2024.
//

import UIKit

final class CustomTableViewCellV2: UITableViewCell {

    // MARK: - Private Properties

    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
//        print("🍑 CustomTableViewCellV2", bounds.size, sizeThatFits(.init(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)), systemLayoutSizeFitting(.init(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)))
        let roundedSize = (round(frame.size.width), round(frame.size.height))
        button.setTitle(String(describing: roundedSize), for: .normal)
    }

    // MARK: - Private

    private func setupContentView() {
        selectionStyle = .none
        
        contentView.addSubview(button)

        let height = button.heightAnchor.constraint(equalToConstant: 50)
        height.priority = .init(999)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            height
        ])
    }
}
