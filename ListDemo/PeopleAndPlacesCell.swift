//
//  PeopleAndPlacesCell.swift
//  ListDemo
//
//  Created by Timur Saidov on 26.04.2024.
//

import UIKit

// Step 8.
final class PeopleAndPlacesCell: UITableViewCell {

    // MARK: - Private Structures

    private enum Constants {
        static let minimumLineSpacing: CGFloat = 10
        static let sideInset: CGFloat = 20
        static let numberOfLines = 0
    }

    // MARK: - Private Properties

    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.sectionInset = .init(top: 0, left: Constants.sideInset, bottom: 0, right: Constants.sideInset)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellId")
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "AlbumCellId")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print("🍏 PeopleAndPlacesCell", frame.size, sizeThatFits(.init(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)), systemLayoutSizeFitting(.init(width: bounds.width, height: UIView.layoutFittingCompressedSize.height)))
//    }

    // MARK: - Private

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension PeopleAndPlacesCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCellId", for: indexPath) as? AlbumCell
        else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellId", for: indexPath)
        }
        
        cell.configure(wth: String(describing: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PeopleAndPlacesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let itemHeight = collectionView.frame.height - sectionInset.top - sectionInset.bottom
        return .init(width: itemHeight, height: itemHeight)
    }
}
