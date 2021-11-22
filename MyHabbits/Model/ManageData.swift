//
//  ManageData.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.10.2021.
//

import Foundation
import CoreData
import UIKit

class ManageCoreData{
    static let shared = ManageCoreData()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()

    func saveData(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
    func getDayOfWeek() -> Int {
        let today = Date()
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: today)
        if weekDay == 1 {
            return 7
        } else {
            return weekDay - 1
        }
    }
    
    func loadHabits(habit: inout [Habit]){
        let weekDay = getDayOfWeek()
        print(weekDay)
        let datePredicate = NSPredicate(format: "%@ IN daysArray.days", weekDay as NSNumber)
        fetchRequest.predicate = datePredicate        
        do {
            habit = try context.fetch(fetchRequest)
        } catch {
            print("Failed with loading data \(error.localizedDescription)")
        }
    }
    
    func loadData(usersHabbits: inout [Habit]){
        fetchRequest.predicate = nil
        do {
            usersHabbits = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed with fetching: \(error.localizedDescription)")
        }
    }
    
    func deleteItem(at indexPath: IndexPath, habit: inout [Habit]){
        context.delete(habit[indexPath.row])
        habit.remove(at: indexPath.row)
    }
    
    func deleteItemInTwoDemensions(at indexPath: IndexPath, habit: inout [HabitsSection]){
        var index = 0
        switch indexPath.section {
        case 0: index = 1
        default: index = 0
        }
        for i in 0...habit[index].habits.count-1 {
            if habit[index].habits[i] == habit[indexPath.section].habits[indexPath.row-1] {
                context.delete(habit[indexPath.section].habits[indexPath.row-1])
                habit[indexPath.section].habits.remove(at: indexPath.row-1)
                habit[index].habits.remove(at: i)
            }
        }
    }
}

