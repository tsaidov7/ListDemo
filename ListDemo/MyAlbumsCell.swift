//
//  MyAlbumsCell.swift
//  ListDemo
//
//  Created by Timur Saidov on 25.04.2024.
//

import UIKit

// Step 5.
class MyAlbumsCell: UITableViewCell {

    private enum Constants {
        static let spacing: CGFloat = 10
        static let sideInset: CGFloat = 20
        static let numberOfLines: CGFloat = 2
    }

    private lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.spacing
        layout.minimumInteritemSpacing = Constants.spacing
        layout.sectionInset = .init(top: 0, left: Constants.sideInset, bottom: 0, right: Constants.sideInset)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellId")
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "AlbumCellId") // Step 7.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyAlbumsCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Step 7.
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellId", for: indexPath)
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCellId", for: indexPath) as? AlbumCell
        else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellId", for: indexPath)
        }
//        cell.layer.borderColor = UIColor.purple.cgColor
//        cell.layer.borderWidth = 2
//        cell.layer.cornerRadius = 10
        cell.setup(wth: String(describing: indexPath))
        return cell
    }
}

// Step 6.
extension MyAlbumsCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        let height = collectionView.frame.height - (Constants.numberOfLines - 1) * interitemSpacing - sectionInset.top - sectionInset.bottom
        let itemHeight = height / Constants.numberOfLines
        return .init(width: itemHeight, height: itemHeight)
    }
}
