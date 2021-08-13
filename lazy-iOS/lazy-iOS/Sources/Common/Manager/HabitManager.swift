//
//  HabitManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/13.
//

import UIKit

protocol HabitManagerDelegate: AnyObject {
    func addHabits(_ habits: [Habit])
    func completedHabit(habit: Habit)
    func incompleteHabit(habit: Habit)
}

class HabitManager {
    static let shared = HabitManager()

    // MARK: - Properties

    private(set) var habits: [Habit] = [] {
        willSet {
            if newValue.count == limit {
                // TODO: - 습관 추가 불가 ..
            }

            print(newValue)
        }
    }

    var delayDaysCount: Int {
        let count = habits.reduce(0) { (result: Int, habit: Habit) in
            result + habit.delayDay
        }

        return count
    }

    private var limit: Int = 3

    var habitCount: Int {
        habits.count
    }

    weak var habitManagerDelegate: HabitManagerDelegate?

    // MARK: - Initializer

    init() {}

    // MARK: - Methods

    func appendHabits(_ habits: [Habit]) {
        let newHabits = habits.filter { !self.habits.contains($0) }
        self.habits.append(contentsOf: newHabits)
        
        habitManagerDelegate?.addHabits(newHabits)
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
