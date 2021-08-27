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

// MARK: - FSCalendarDelegate

extension DetailHabitViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currPage = calendar.currentPage
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: IconCalendarCell.self), for: date, at: position)

        return cell
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        configure(cell: cell, for: date, at: monthPosition)
    }

}
