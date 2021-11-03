//
//  ColorTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
//    private let colorButtons = ColorButtons()
    
    let pinkButton = ColorButton(color: Constants.Colors.pink,colorName: "pink", tag: 11)
    
    
    let blueButton = ColorButton(color: Constants.Colors.blue, colorName: "blue", tag: 12)
    
    
    let orangeButton = ColorButton(color: Constants.Colors.orange, colorName: "orange", tag: 13)
    
    
    let greenButton = ColorButton(color: Constants.Colors.green, colorName: "green", tag: 14)
    
    
    private let selectColorLabel = AddViewLabel(title: "Select label color:")
    
    private let colorStack: UIStackView = {
        let colorsStack = UIStackView()
        colorsStack.axis = .horizontal
        colorsStack.spacing = 15
        colorsStack.distribution = .fillEqually
        return colorsStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            setConstraints(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
        let colorButtonsArray = [pinkButton, blueButton, orangeButton, greenButton]
        for button in colorButtonsArray {
            colorStack.addArrangedSubview(button)
        }

        let cellStack = CellStack.addStack(with: [selectColorLabel,colorStack], view)
        
        NSLayoutConstraint.activate([
            colorStack.heightAnchor.constraint(equalToConstant: 45),
            colorStack.widthAnchor.constraint(equalTo: colorStack.heightAnchor, multiplier: 5),
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -20)
        ])
    }

}
