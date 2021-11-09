//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 31.10.2021.
//

import UIKit

struct SelectLogic {
    
    var selectedColor: String?
    
    var arrayOfSelectedButtons = [Int]()
    var selectedTimeToRemind = Date()
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
    
    func createDate(weekday: Int, hour: Int, minute: Int, year: Int) -> Date{

            var components = DateComponents()
            components.hour = hour
            components.minute = minute
            components.weekday = weekday // sunday = 1 ... saturday = 7
            components.year = year
            components.timeZone = .current

        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)!
        }
    
}
