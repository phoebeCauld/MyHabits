//
//  SelectColorLogic.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 30.10.2021.
//

import UIKit

class ColorButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(color: UIColor, colorName: String, tag: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        backgroundColor = color
        self.tag = tag
        accessibilityIdentifier = colorName
        layer.cornerRadius = 0.5 * frame.size.width
        clipsToBounds = true
        addTarget(AddHabitViewController(),
                  action: #selector(AddHabitViewController.selectColorsPressed),
                  for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
