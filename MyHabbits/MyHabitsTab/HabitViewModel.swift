//
//  HabitViewModel.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.11.2021.
//

import Foundation
import UIKit

struct HabitViewModel{
    
    func currentColorForHabit(with currentColor: String, for background: UIView){
        switch currentColor {
        case "pink": background.backgroundColor = Constants.Colors.pink
        case "blue": background.backgroundColor = Constants.Colors.blue
        case "orange": background.backgroundColor = Constants.Colors.orange
        case "green": background.backgroundColor = Constants.Colors.green
        default: background.backgroundColor = Constants.Colors.defaultColor
        }
    }
    
    func deleteHabit(){
        
    }
}


