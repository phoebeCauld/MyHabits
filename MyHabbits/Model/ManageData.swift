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
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Habbit")
    let fetchRequest: NSFetchRequest<Habbit> = Habbit.fetchRequest()

    
//    func addData(title: String, days: [Int16], usersHabbits: inout [NSManagedObject]){
//        guard let entity = NSEntityDescription.entity(forEntityName: "Habbit", in: context) else {return}
//        let habbit = NSManagedObject(entity: entity, insertInto: context)
//        habbit.setValuesForKeys(["title":title, "daysArray": days])
//        do {
//            try context.save()
//            usersHabbits.append(habbit)
//        } catch let error as NSError {
//            print("Failed with saving data: \(error.localizedDescription)")
//        }
//    }
    
    func saveData(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
//    func addDaysData(day: Int, selectedDays: inout [NSManagedObject]){
//        guard let entity = NSEntityDescription.entity(forEntityName: "DaysToRemind", in: context) else {return}
//        let selectedDay = NSManagedObject(entity: entity, insertInto: context)
//        selectedDay.setValuesForKeys(["days":day])
//        do {
//            try context.save()
//            selectedDays.append(selectedDay)
//        } catch let error as NSError {
//            print("Failed with saving data: \(error.localizedDescription)")
//        }
//    }
    
    func loadData(usersHabbits: inout [Habbit]){
        do {
            usersHabbits = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed with fetching: \(error.localizedDescription)")
        }
    }
    
}
