//
//  HabitManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/13.
//

import UIKit

protocol HomeHabitManagerDelegate: AnyObject {
    func addHabits(_ habits: [Habit])
    func completedHabit(habit: Habit)
    func incompleteHabit(habit: Habit)
}

protocol DrawerHabitManagerDelegate: AnyObject {
    func addHabits(_ habits: [Habit])
    func completedHabit(habit: Habit)
    func incompleteHabit(habit: Habit)
}

class HabitManager {
    static let shared = HabitManager()

    // MARK: - Properties

    private(set) var habits: [Habit] = [] {
        didSet {
            drawerHabitManagerDelegate?.addHabits(habits)
        }
    }

    var delayDaysCount: Int {
        habits.reduce(0) { $0 + $1.delayDay }
    }

    private var limit: Int = 3

    var habitCount: Int {
        habits.count
    }

    weak var homeHabitManagerDelegate: HomeHabitManagerDelegate?
    weak var drawerHabitManagerDelegate: DrawerHabitManagerDelegate?

    // MARK: - Initializer

    init() {}

    // MARK: - Methods

    func appendHabits(_ habits: [Habit]) {
        let newHabits = habits.filter { !self.habits.contains($0) }

        homeHabitManagerDelegate?.addHabits(newHabits)
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
