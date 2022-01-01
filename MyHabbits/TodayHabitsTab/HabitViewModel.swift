//
//  HabitViewModel.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.11.2021.
//

import Foundation
import UIKit

struct HabitViewModel {

    var done: Bool = false
    var currentDay = Date()
    var oldDate: Date?

    func currentColorForHabit(with currentColor: String) -> UIColor {
        switch currentColor {
        case "pink": return Constants.Colors.pink
        case "blue": return Constants.Colors.blue
        case "orange": return Constants.Colors.orange
        case "green": return Constants.Colors.green
        default: return Constants.Colors.defaultColor
        }
    }

    func doneState(is done: Bool, cell: HabbitsCell) {
        if done {
            cell.cellView.backgroundColor = UIColor(white: 0.86, alpha: 1)
            cell.title.textColor = .lightGray
        } else {
            cell.title.textColor = .black
        }
    }

    func currentdayCheck(for habits: [Habit], isNewDay: Bool) {
        if isNewDay {
            for habit in habits {
                habit.isDone = false
            }
        }
    }
}
