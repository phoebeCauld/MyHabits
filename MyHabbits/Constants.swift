//
//  Constants.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import Foundation
import UIKit

struct Constants {
    static let mainViewCellIdentifier = "Cell"
    static let sectoinsCellIdentifier = "sectoinCell"
    static let nameCellIdentifier = "nameCell"
    static let daysCellIdentifier = "daysCell"
    static let notificationCellIdentifier = "notificationCell"
    static let colorCellIdentifier = "colorCell"
    
    struct ImageLabels {
        static let calendarImage = UIImage(systemName: "calendar")
        static let listImage = UIImage(systemName: "list.bullet")
        static let progressImage = UIImage(systemName: "chart.line.uptrend.xyaxis")
        static let openImage = UIImage(systemName: "chevron.down")
        static let closeImage = UIImage(systemName: "chevron.up")
        static let checkImage = UIImage(systemName: "checkmark.circle")
        static let checkDoneImage = UIImage(systemName: "checkmark.circle.fill")
        static let trashImage = UIImage(systemName: "trash")
        static let doneImage = UIImage(systemName: "checkmark")
        static let editImage = UIImage(systemName: "pencil")
    }
    
    struct Colors {
        static let defaultColor: UIColor = .systemBlue
        static let pink: UIColor = UIColor(red: 0.97, green: 0.65, blue: 0.76, alpha: 1.00)
        static let blue: UIColor = UIColor(red: 0.47, green: 0.55, blue: 0.92, alpha: 1.00)
        static let orange: UIColor = UIColor(red: 0.98, green: 0.69, blue: 0.63, alpha: 1.00)
        static let green: UIColor = UIColor(red: 0.39, green: 0.80, blue: 0.85, alpha: 1.00)
    }
}

struct LocalizedString {
    static let addTitle = NSLocalizedString("Add new habit", comment: "")
    static let updateTitle = NSLocalizedString("Update ", comment: "")
    static let canselButton = NSLocalizedString("Close", comment: "")
    static let nameLabel = NSLocalizedString("I want to start:", comment: "")
    static let daysLabel = NSLocalizedString("I want do this every:", comment: "")
    static let notificationLabel = NSLocalizedString("Send me notification to remind", comment: "")
    static let colorLabel = NSLocalizedString("Select label color:", comment: "")
    static let emptyNameLabel = NSLocalizedString("Empty name!", comment: "")
    static let emptyNameDescription = NSLocalizedString("Please, enter the name of your new habit", comment: "")
    static let todayHabits = NSLocalizedString("Today Habits", comment: "")
    static let allHabits = NSLocalizedString("All Habits", comment: "")
    static let everyDay = NSLocalizedString("Every day", comment: "")
    static let notificationBody = NSLocalizedString("Don't forget to ", comment: "")
    static let deleteLabel = NSLocalizedString("Delete", comment: "")
    static let cancelLabel = NSLocalizedString("Cancel", comment: "")
    static let editLabel = NSLocalizedString("Edit", comment: "")
    static let doneLabel = NSLocalizedString("Done", comment: "")
    static let undoneLabel = NSLocalizedString("Undone", comment: "")
    static let placeholder1 = NSLocalizedString("Drink water", comment: "")
    static let placeholder2 = NSLocalizedString("Workout", comment: "")
    static let placeholder3 = NSLocalizedString("Eat vegetables", comment: "")
    static let placeholder4 = NSLocalizedString("Go for a walk", comment: "")

    static let mon = NSLocalizedString("Mon", comment: "")
    static let tue = NSLocalizedString("Tue", comment: "")
    static let wed = NSLocalizedString("Wed", comment: "")
    static let thu = NSLocalizedString("Thu", comment: "")
    static let fri = NSLocalizedString("Fri", comment: "")
    static let sat = NSLocalizedString("Sat", comment: "")
    static let sun = NSLocalizedString("Sun", comment: "")

    
    
}


