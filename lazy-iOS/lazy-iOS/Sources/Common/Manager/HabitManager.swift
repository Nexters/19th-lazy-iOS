//
//  HabitManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/13.
//

import UIKit

@objc
protocol HabitManagerDelegate {
    @objc optional func completedHabit(habit: Int)
}

class HabitManager {
    static let shared = HabitManager()

    var habits: [Habit] = [Habit(idx: 3, iconIdx: 2, name: "런데이! 🏃🏼‍♀️", frequency: 5, delayDay: 6, registrationDate: Date(), isAlarm: true, repeatDays: [0, 1, 2, 3, 4, 5, 6], completion: false)] {
        willSet {
            if newValue.count == limit {
                // TODO: - 습관 추가 불가 ..
            }
        }

        didSet {
            print("새 데이터가 들어왔다!")
            print(habits)
        }
    }

    private var limit: Int = 3

    var habitCount: Int {
        habits.count
    }
}

/// 임시....
/// `["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]`.
struct Habit {
    let idx: Int
    var iconIdx: Int
    var name: String
    var frequency: Int
    var delayDay: Int
    let registrationDate: Date
    var isAlarm: Bool
    var repeatDays: [Int]
    var completion: Bool
}
