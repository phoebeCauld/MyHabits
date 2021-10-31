//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 31.10.2021.
//

import UIKit

struct SelectColorLogic {
    
    var selectedColor: String?
    
    mutating func updateButtonStates(_ arrayOfButtons:[UIButton], _ sender: UIButton) {
        for button in arrayOfButtons {
            button.isSelected = false
            button.layer.borderWidth = 0
        }
        sender.isSelected = true
        sender.layer.borderWidth = 1.5
        guard let colorName = sender.accessibilityIdentifier else { return }
        selectedColor = colorName
    }
}
