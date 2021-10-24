//
//  SelectedDayLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 23.10.2021.
//

import Foundation

struct SelectedDayLogic {
    var arrayOfSelectedButtons = [Int]()
    var dayDict = [1: false, 2: false, 3: false,4:false, 5:false, 6:false, 7:false]
    
    mutating func selectDay(key: Int){
        dayDict[key] = !(dayDict[key] ?? false)
    }
    mutating func arrayOfSelected() -> [Int] {
        for (key,value) in dayDict {
            if value == true{
                arrayOfSelectedButtons.append(key)
            }
        }
        return arrayOfSelectedButtons.sorted()
    }
}
