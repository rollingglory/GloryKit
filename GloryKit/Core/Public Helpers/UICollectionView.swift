//
//  UICollectionView.swift
//  GloryKit
//
//  Created by Rolling Glory on 16/10/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation

/// UICollectionView's public helper.
public extension UICollectionView {
    // MARK: - Cell & View
    /// Cell registrar.
    /// - Usage: `collectionView.register(CellClassName.self)`
    func register<T: UICollectionViewCell>(_ cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    /// Cell registrar in list.
    /// - Usage: `collectionView.register([CellOne.self, CellTwo.self])`
    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register($0, bundle: bundle) }
    }
    
    /// View registrar.
    /// - Usage: `collectionView.register(reusableViewType: CollectionHeader.view)`
    func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                      bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    /// View registrar in list.
    /// - Usage: `collectionView.register(reusableViewType: [CollectionHeader.self, CollectionFooter.self])`
    func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                               ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                      bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    /// Cell dequeuer.
    /// - Usage: `collectionView.dequeueCell(with: MyCell.self, for: indexPath)`
    func dequeueCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    /// View dequeuer.
    /// - Usage: `collectionView.dequeueView(with: MyView.self, for: indexPath)`
    func dequeueView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}
