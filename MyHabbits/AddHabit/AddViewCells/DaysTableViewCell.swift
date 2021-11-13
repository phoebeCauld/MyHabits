//
//  DaysTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    private let dayButton = DaysButton()
    
    let chooseDayLabel = AddViewLabel(title: "I want do this every")

    private let daysStack: UIStackView = {
        let daysStack = UIStackView()
        daysStack.axis = .horizontal
        daysStack.spacing = 5
        daysStack.distribution = .fillEqually
        daysStack.translatesAutoresizingMaskIntoConstraints = false
        return daysStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
        let arrayOfButtons = dayButton.createButtons()
        for button in arrayOfButtons {
            daysStack.addArrangedSubview(button)
        }
        let cellStack = CellStack.addStack(with: [chooseDayLabel,daysStack], view)
        
        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -20),
            daysStack.heightAnchor.constraint(equalToConstant: 45),
            daysStack.widthAnchor.constraint(equalTo: cellStack.widthAnchor)
        ])
    }
}
