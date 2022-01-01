//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 31.10.2021.
//

import UIKit

struct SelectLogic {

    private let notifications = NotificationsManager()
    var selectedColor: String?
    private var arrayOfSelectedButtons = [Int]()
    var selectedTimeToRemind: Date?
    var oldReminder: Bool = false

    private var dayDict = [2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 1: false]

    mutating func selectDay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let key = sender.tag
        dayDict[key] = !(dayDict[key] ?? false)

        if sender.isSelected {
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
        } else {
            sender.backgroundColor = .white
            sender.setTitleColor(.systemBlue, for: .normal)
        }
    }

    mutating func arrayOfSelected() -> [Int] {
        for (key, value) in dayDict where value == true {
                arrayOfSelectedButtons.append(key)
        }
        return arrayOfSelectedButtons
    }

    mutating func selectColorButton(_ self: UIViewController, _ sender: UIButton) {
        let allButtonTags = [11, 12, 13, 14]
        let currentButtonTag = sender.tag

        allButtonTags.filter { $0 != currentButtonTag }.forEach { tag in
            if let button = self.view.viewWithTag(tag) as? UIButton {
                button.layer.borderWidth = 0
                button.isSelected = false
            }
        }
        sender.layer.borderWidth = 1.5
        sender.isSelected = true
        guard let color = sender.accessibilityIdentifier else { return }
        selectedColor = color
    }

    func createDate(weekday: Int) -> Int {
        switch weekday {
        case 7: return 1
        default: return weekday + 1
        }
    }

    mutating func addHabit(with name: String, isRemindning: Bool) {
        let newHabit = Habit(context: ManageCoreData.shared.context)
        newHabit.title = name
        newHabit.identifier = UUID()
        newHabit.isRemindning = isRemindning
        newHabit.labelColor = selectedColor
        newHabit.isDone = false
        let selectedDays = arrayOfSelected()
        for day in selectedDays {
            let notificationDay = selectedTimeToRemind
            newHabit.timeToRemind = notificationDay
            let notifyDay = createDate(weekday: day)
            let newDay = DaysToRemind(context: ManageCoreData.shared.context)
            newDay.days = Int16(day)
            newDay.id = UUID().uuidString
            notifications.scheduleNotification(for: newHabit, day: notifyDay, dayId: newDay.id ?? "")
            newDay.parentHabit = newHabit
        }
    }

    mutating func updateHabit(habit: Habit, name: String, isReminding: Bool) {
        habit.title = name
        habit.labelColor = selectedColor
        habit.isDone = false
        habit.isRemindning = isReminding
        if oldReminder && !isReminding {
            notifications.deleteNotificiation(with: habit.identifier?.uuidString ?? "",
                                              daysIds: oldDaysId(for: habit))
        }
        if habit.timeToRemind != selectedTimeToRemind {
            habit.timeToRemind = selectedTimeToRemind
        }
        let selectedDays = arrayOfSelected()
        notifications.deleteNotificiation(with: habit.identifier?.uuidString ?? "",
                                                      daysIds: oldDaysId(for: habit))
        habit.daysArray = []
        for day in selectedDays {
            let notifyDay = createDate(weekday: day)
            let newDay = DaysToRemind(context: ManageCoreData.shared.context)
            newDay.days = Int16(day)
            newDay.id = UUID().uuidString
            newDay.parentHabit = habit
            notifications.scheduleNotification(for: habit, day: notifyDay, dayId: newDay.id ?? "")
        }
    }

    mutating func updateRemindSwitch(for habit: Habit, isReminding: Bool) {
        oldReminder = habit.isRemindning
        habit.isRemindning = isReminding
    }

    func oldDaysArray(habit: Habit) -> [Int] {
        if let daysArray = habit.daysArray?.value(forKey: "days") {
            let selectedDaysArray = daysArray as! Set<Int>
            return Array(selectedDaysArray)
        }
        return []
    }

    mutating func selectOldDays(_ key: Int, _ button: UIButton) {
        dayDict[key] = true
        button.isSelected = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
    }

    func oldDaysId(for habit: Habit) -> [String] {
        if let daysId = habit.daysArray?.value(forKey: "id") as? Set<String> {
            return Array(daysId)
        }
        return []
    }
}
