//
//  DetailHabitViewController+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/11.
//

import FSCalendar
import UIKit

// MARK: - NavigationDelegate

extension DetailHabitViewController: NavigationDelegate {
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewFlowLayout

extension DetailHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = habitsCollectionView.frame.height
        return CGSize(width: buttonWidth, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ((habitsCollectionView.frame.width - (buttonWidth * 3)) / 2)
    }
}

// MARK: - UICollectionViewDataSource

extension DetailHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HabitButtonCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        return cell
    }
}

// MARK: - FSCalendarDataSource

extension DetailHabitViewController: FSCalendarDataSource {}
