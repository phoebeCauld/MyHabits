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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()

    func saveData(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
    func loadData(usersHabbits: inout [Habit]){
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
    
}
