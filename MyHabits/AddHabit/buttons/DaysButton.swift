//
//  DaysButton.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 22.10.2021.
//

import UIKit

class DaysButton: UIButton {

    func configButton(title: String, tag: Int) -> UIButton {
        let dayButtons = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        dayButtons.setTitle(title, for: .normal)
        dayButtons.tag = tag + 1
        dayButtons.setTitleColor(.systemBlue, for: .normal)
        dayButtons.layer.cornerRadius = 0.5 * dayButtons.bounds.size.width
        dayButtons.clipsToBounds = true
        dayButtons.layer.borderWidth = 1
        dayButtons.translatesAutoresizingMaskIntoConstraints = false
        dayButtons.addTarget(AddHabitViewController(),
                             action: #selector(AddHabitViewController.dayButtonPressed),
                             for: .touchUpInside)
        return dayButtons
    }

    func createButtons() -> [UIButton] {
        var arrayOfButtons = [UIButton]()
        let daysNames = [
            LocalizedString.mon,
            LocalizedString.tue,
            LocalizedString.wed,
            LocalizedString.thu,
            LocalizedString.fri,
            LocalizedString.sat,
            LocalizedString.sun
        ]
        for days in 0...daysNames.count-1 {
            let button = configButton(title: daysNames[days], tag: days)
            arrayOfButtons.append(button)
        }
        return arrayOfButtons
    }
}
