//
//  DaysButton.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.10.2021.
//

import UIKit

class DaysButton: UIButton {
    
    func configButton(title: String, tag: Int) -> UIButton{
        let dayButtons = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        dayButtons.tag = tag + 1
        dayButtons.setTitle(title, for: .normal)
        dayButtons.setTitleColor(.systemBlue, for: .normal)
        dayButtons.layer.cornerRadius = 0.5 * dayButtons.bounds.size.width
        dayButtons.clipsToBounds = true
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
}
