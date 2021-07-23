//
//  UICollectionView+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit
extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable Cell")
        }

        return cell
    }

    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
}
