//
//  AddHabitViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension EditHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayOfWeekCollectionView {
            return weeks.count
        }
        return BubbleIcon.iconCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case dayOfWeekCollectionView:
            let cell: DayOfWeekCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setCell(day: weeks[indexPath.row])

            return cell
        case iconCollectionView:
            let cell: IconCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setIconImage(idx: indexPath.row + 1)

            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EditHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dayOfWeekCollectionView {
            let width = Int(dayOfWeekCollectionView.frame.width) - (11 * (weeks.count - 1))
            let size = Double(width) / Double(weeks.count)

            return CGSize(width: size, height: size)
        }
        return CGSize(width: 42, height: 42)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == dayOfWeekCollectionView {
            return 11
        }
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
}

extension EditHabitViewController: UICollectionViewDelegate {
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

// MARK: - UITextFieldDelegate

extension EditHabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
