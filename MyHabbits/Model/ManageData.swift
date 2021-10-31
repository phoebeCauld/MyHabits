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
    let fetchRequest: NSFetchRequest<Habbit> = Habbit.fetchRequest()

    func saveData(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }
    
    func loadData(usersHabbits: inout [Habbit]){
        do {
            usersHabbits = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed with fetching: \(error.localizedDescription)")
        }
    }
    
}
