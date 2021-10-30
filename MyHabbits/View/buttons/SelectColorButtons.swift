//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 30.10.2021.
//

import UIKit

class SelectColorButtons: UIButton {
    func configButtons(color: UIColor) -> UIButton{
        let colorButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        colorButton.backgroundColor = color
        colorButton.layer.cornerRadius = 0.5 * colorButton.bounds.size.width
        colorButton.clipsToBounds = true
        colorButton.layer.borderWidth = 1
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        return colorButton
    }
    
    func createColorButtons() -> [UIButton] {
        var arrayOfButtons = [UIButton]()
        let colorArray:[UIColor] = [UIColor(red: 0.97, green: 0.65, blue: 0.76, alpha: 1.00), UIColor(red: 0.47, green: 0.55, blue: 0.92, alpha: 1.00), UIColor(red: 0.98, green: 0.69, blue: 0.63, alpha: 1.00), UIColor(red: 0.39, green: 0.80, blue: 0.85, alpha: 1.00)]
        for i in 0...colorArray.count-1 {
            let button = configButtons(color: colorArray[i])
            arrayOfButtons.append(button)
        }
        return arrayOfButtons
    }
}
