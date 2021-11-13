//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 31.10.2021.
//

import UIKit

struct SelectLogic {
    
    private var habits = [Habit]()
    private var daysToRemind = [DaysToRemind]()
    private let notifications = NotificationsManager()
    var selectedColor: String?
    var arrayOfSelectedButtons = [Int]()
    var selectedTimeToRemind: Date?
    
    var dayDict = [1: false, 2: false, 3: false,4:false, 5:false, 6:false, 7:false]
    
    mutating func selectDay(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        let key = sender.tag
        dayDict[key] = !(dayDict[key] ?? false)
        
        if sender.isSelected{
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
        }   else {
            sender.backgroundColor = .white
            sender.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    func oldDaySelection(days: [Int]){
        
    }
    
    mutating func arrayOfSelected() -> [Int] {
        for (key,value) in dayDict {
            if value == true{
                arrayOfSelectedButtons.append(key)
            }
        }
        return arrayOfSelectedButtons.sorted()
    }
    
    mutating func updateButtonStates(_ self: UIViewController, _ sender: UIButton) {
        let allButtonTags = [11,12,13,14]
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
    
    func createDate(weekday: Int) -> Date?{
        guard let selectDate = selectedTimeToRemind else { return nil }
        let date = Calendar.current.dateComponents([.hour, .minute, .second, .year], from: selectDate)
        var components = DateComponents()
        components.hour = date.hour
        components.minute = date.minute
        components.weekday = weekday // sunday = 1 ... saturday = 7
        components.year = date.year
        components.timeZone = .current

        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)!
        }
    
    mutating func addHabit(with name: String, isRemindning: Bool){
        let newHabit = Habit(context: ManageCoreData.shared.context)
        newHabit.title = name
        newHabit.identifier = UUID()
        newHabit.isRemindning = isRemindning
        newHabit.labelColor = selectedColor
        let selectedDays = arrayOfSelected()
        for day in selectedDays {
            let notificationDay = createDate(weekday: day)
            newHabit.timeToRemind = notificationDay
            notifications.scheduleNotification(for: newHabit)
            let newDay = DaysToRemind(context: ManageCoreData.shared.context)
            newDay.days = Int16(day)
            newDay.parentHabit = newHabit
            daysToRemind.append(newDay)
        }
    }
    
    func updateHabit(habit: Habit, name: String, isReminding: Bool){
        habit.title = name
        habit.labelColor = selectedColor
        let oldStatus = habit.isRemindning
        habit.isRemindning = isReminding
        if !oldStatus && isReminding {
            notifications.deleteNotificiation(with: habit.identifier?.uuidString ?? "")
        }
    }
    
    func updateRemindSwitch(for habit: Habit, isReminding: Bool){
        let oldStatus = habit.isRemindning
        habit.isRemindning = isReminding
//        ManageCoreData.shared.saveData()
//        if !oldStatus && isReminding {
//            notifications.deleteNotificiation(with: habit.identifier?.uuidString ?? "")
//        }
    }
    
    func oldSelectedDays(habit: Habit){
        
    }
}

