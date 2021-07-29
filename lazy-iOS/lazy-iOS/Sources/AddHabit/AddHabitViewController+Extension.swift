//
//  AddHabitViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension AddHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayOfWeekCollectionView {
            return weeks.count
        }
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case dayOfWeekCollectionView:
            let cell: DayOfWeekCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setCell(day: weeks[indexPath.row])

            return cell
        case iconCollectionView:
            let cell: IconCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.contentView.backgroundColor = colors[indexPath.row]

            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dayOfWeekCollectionView {
            return CGSize(width: 34, height: 34)
        }
        return CGSize(width: 42, height: 42)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == iconCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }

        return .zero
    }
}

extension AddHabitViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isFirst {
            let range = collectionView.numberOfItems(inSection: 0)
            for idx in 0 ..< range {
                collectionView.cellForItem(at: IndexPath(row: idx, section: 0))?.isSelected = false
            }
        }

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        isFirst = false
    }
}
