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

    private(set) var habits: [Habit] = [] {
        willSet {
            if newValue.count == limit {
                // TODO: - 습관 추가 불가 ..
            }

            print(newValue)
        }
    }

    private var limit: Int = 3

    var habitCount: Int {
        habits.count
    }

    var delayDaysCount: Int {
        let count = habits.reduce(0) { (result: Int, habit: Habit) in
            result + habit.delayDay
        }

        return count
    }

    // MARK: - Initializer

    init() {
        habits = [Habit(idx: 3, iconIdx: 2, name: "런데이! 🏃🏼‍♀️", frequency: 5, delayDay: 6, registrationDate: Date(), isAlarm: true, repeatDays: [1, 3, 5, 7], completion: false)]
    }

    // MARK: - Methods

    func appendHabits(_ habits: [Habit]) {
        let newHabits = habits.filter { !self.habits.contains($0) }
        self.habits.append(contentsOf: newHabits)
    }
}

/// 임시....
/// `["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]`.
struct Habit: Equatable {
    let idx: Int
    var iconIdx: Int
    var name: String
    var frequency: Int
    var delayDay: Int
    let registrationDate: Date
    var isAlarm: Bool
    var repeatDays: [Int]
    var completion: Bool

    static func ==(lhs: Habit, rhs: Habit) -> Bool {
        lhs.idx == rhs.idx
    }
}
