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

// MARK: - FSCalendarDataSource

extension DetailHabitViewController: FSCalendarDataSource {}
