//
//  UITableView.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 16/10/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation

/// UITableView's public helper.
public extension UITableView {
    // MARK: - Cell
    /// Cell registrar.
    /// - Usage: `tableView.register(CellClassName.self)`
    func register<T: UITableViewCell>(_ cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    /// Cell registrar in list.
    /// - Usage: `tableView.register([CellOne.self, CellTwo.self], bundle: nil)`
    func register<T: UITableViewCell>(_ cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register($0, bundle: bundle) }
    }

    /// Cell dequeuer.
    /// - Usage: `tableView.dequeueReusableCell(with: MyCell.self, for: indexPath)`
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
