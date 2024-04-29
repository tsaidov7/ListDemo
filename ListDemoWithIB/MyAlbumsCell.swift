//
//  MyAlbumsCell.swift
//  ListDemoWithIB
//
//  Created by Timur Saidov on 29.04.2024.
//

import UIKit

// Step 5.
final class MyAlbumsCell: UITableViewCell {

    // MARK: - Private Structures

    private enum Constants {
        static let numberOfLines: CGFloat = 2
    }

    // MARK: - Private Properties

    @IBOutlet private weak var collectionView: UICollectionView!
}

// MARK: - UICollectionViewDataSource

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
        cell.configure(wth: String(describing: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// Step 6.
extension MyAlbumsCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Свойство estimatedItemSize используется, когда ячейки имеют динамически изменяемый размер. Расчетное значение позволяет collection view отложить некоторые вычисления для определения фактического размера содержимого. Предполагается, что ячейки, которые не отображаются на экране, имеют расчетную высоту.
        // В сториборде установить Estimate Size = None.
        // Установка значения, отличного от .zero (None), например, automaticSize, приводит к тому, что collection view запрашивает у каждой ячейки ее фактический размер, используя метод preferredLayoutAttributesFitting(_:) ячейки.
        // https://stackoverflow.com/questions/40019875/set-collectionview-size-sizeforitematindexpath-function-is-not-working-swift
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interitemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        let height = collectionView.frame.height - (Constants.numberOfLines - 1) * interitemSpacing - sectionInset.top - sectionInset.bottom
        let itemHeight = height / Constants.numberOfLines
        return .init(width: itemHeight, height: itemHeight)
    }
}
