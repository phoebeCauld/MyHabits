//
//  HabitViewModel.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.11.2021.
//

import Foundation
import UIKit

struct HabitViewModel{

    var done: Bool = false
    var currentDay = Date()
    var oldDate: Date?
    
    
    func currentColorForHabit(with currentColor: String) -> UIColor{
        switch currentColor {
        case "pink": return Constants.Colors.pink
        case "blue": return Constants.Colors.blue
        case "orange": return Constants.Colors.orange
        case "green": return Constants.Colors.green
        default: return Constants.Colors.defaultColor
        }
    }
    
    func doneState(is done: Bool, cell: HabbitsCell){
        print("the habit is \(done)")
        if done{
            cell.cellView.backgroundColor = .lightGray
            cell.title.textColor = .lightText
        } else {
            cell.title.textColor = .black
        }
    }
    
    func currentdayCheck(for habits: [Habit], isNewDay:Bool){
        switch isNewDay {
        case true : for habit in habits {
            habit.isDone = false
        }
        case false : print("false")
        }
    }
}


