//
//  ColorTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    private let addView = AddHabitView()
    private let selectColorLabel = AddViewLabel(title: "Select label color:")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            setConstraints(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
        let colorsStack = UIStackView(arrangedSubviews: [addView.pinkButton,addView.blueButton,addView.orangeButton,addView.greenButton])
        colorsStack.axis = .horizontal
        colorsStack.spacing = 15
        colorsStack.distribution = .fillEqually

        let cellStack = CellStack.addStack(with: [selectColorLabel,colorsStack], view)
        
        NSLayoutConstraint.activate([
            colorsStack.heightAnchor.constraint(equalToConstant: 45),
            colorsStack.widthAnchor.constraint(equalTo: colorsStack.heightAnchor, multiplier: 5),
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
