//
//  HabitManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/13.
//

import UIKit

protocol HomeHabitManagerDelegate: AnyObject {
    func addHabits(_ habits: [Habit])
    func emptyHabit()
    func completedHabit(habit: Habit)
    func incompleteHabit(habit: Habit)
    func isHiddenCompletedLabel(isHidden: Bool)
}

protocol DrawerHabitManagerDelegate: AnyObject {
    func addHabits(_ habits: [Habit])
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
        let count = habits.reduce(0) { $0 + $1.delayDay }

        homeHabitManagerDelegate?.isHiddenCompletedLabel(isHidden: count != 0)
        return count
    }

    private var limit: Int = 3

    var habitCount: Int {
        habits.count
    }

    var bubbleSize: CGFloat {
        switch delayDaysCount {
        case 0...7:
            return 150.0
        case 8...18:
            return 110.0
        default:
            return 70.0
        }
    }

    weak var homeHabitManagerDelegate: HomeHabitManagerDelegate?
    weak var drawerHabitManagerDelegate: DrawerHabitManagerDelegate?

    // MARK: - Initializer

    init() {}

    // MARK: - Methods

    func refreshHabits(_ habits: [Habit]) {
        self.habits = habits

        if habits.isEmpty {
            homeHabitManagerDelegate?.emptyHabit()
        } else {
            homeHabitManagerDelegate?.addHabits(habits)
        }
    }

    func appendHabits(_ habits: [Habit]) {
        let newHabits = habits.filter { !self.habits.contains($0) }

        homeHabitManagerDelegate?.addHabits(newHabits)
        self.habits.append(contentsOf: newHabits)
    }

    func completionHabit(target: Habit, isCompletion: Bool) {
        guard var target = habits.filter({ $0.idx == target.idx }).first,
              let arrIdx = habits.firstIndex(of: target) else { return }
        target.delayDay = isCompletion ? 0 : 1
        target.completion = isCompletion
        habits[arrIdx] = target

        isCompletion ? homeHabitManagerDelegate?.completedHabit(habit: target) : homeHabitManagerDelegate?.incompleteHabit(habit: target)
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
