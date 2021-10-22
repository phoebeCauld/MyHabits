//
//  DaysButton.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.10.2021.
//

import UIKit

class DaysButton: UIButton {
    
    func configButton(title: String, tag: Int) -> UIButton{
        let dayButtons = UIButton()
        dayButtons.tag = tag + 1
        dayButtons.setTitle(title, for: .normal)
        dayButtons.setTitleColor(.systemBlue, for: .normal)
        dayButtons.layer.cornerRadius = 20
        dayButtons.layer.borderWidth = 1
        dayButtons.translatesAutoresizingMaskIntoConstraints = false
        dayButtons.addTarget(AddViewController(), action: #selector(AddViewController.dayButtonPressed), for: .touchUpInside)
//        stackView.addArrangedSubview(dayButtons)
        return dayButtons
    }
    
    func createButtons() -> [UIButton] {
        var arrayOfButtons = [UIButton]()
        let daysNames = ["Mon","Tue", "Wed","Thu", "Fri", "Sat", "Sun"]
        for i in 0...daysNames.count-1 {
           let button = configButton(title: daysNames[i], tag: i)
            arrayOfButtons.append(button)
        }
        return arrayOfButtons
    }
        
//    func updateButtonStates(_ arrayButtons: [UIButton], _ sender: UIButton) {
//        for button in arrayButtons {
//            button.isSelected = false
//            button.backgroundColor = .clear
//            button.setTitleColor(.systemGreen, for: .normal)
//        }
//        if sender
//        sender.isSelected = true
//        sender.backgroundColor = .systemBlue
//        sender.setTitleColor(.white, for: .selected)
//    }
}
