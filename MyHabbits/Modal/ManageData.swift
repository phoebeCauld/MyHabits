//
//  ManageData.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.10.2021.
//

import Foundation
import CoreData
import UIKit

class CoreData{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Habbit")
    
    func addData(title: String, date: Date, usersHabbits: inout [NSManagedObject]){
        guard let entity = NSEntityDescription.entity(forEntityName: "Habbit", in: context) else {return}
        let habbit = NSManagedObject(entity: entity, insertInto: context)
        habbit.setValuesForKeys(["title":title,"date":date])
        do {
            try context.save()
            usersHabbits.append(habbit)
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
    
    func loadData(usersHabbits: inout [NSManagedObject]){
        do {
            usersHabbits = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed with fetching: \(error.localizedDescription)")
        }
    }
}
