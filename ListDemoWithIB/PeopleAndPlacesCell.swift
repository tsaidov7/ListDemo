//
//  PeopleAndPlacesCell.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 30.04.2024.
//

import UIKit

// Step 8.
final class PeopleAndPlacesCell: UITableViewCell {

    // MARK: - Private Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
}

// MARK: - UICollectionViewDataSource

extension PeopleAndPlacesCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCellId", for: indexPath) as? PlacesCell
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
