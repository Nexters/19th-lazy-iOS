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
            return 7
        }
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DayOfWeekCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setCell(day: weeks[indexPath.row])

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 34, height: 34)
    }
}
