//
//  Date+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import Foundation

extension Date {
    func dateToString(format: String = "yyyy-MM-dd", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }

    func stringToDate(format: String = "yyyy-MM-dd", date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: date) ?? Date()
    }
}
