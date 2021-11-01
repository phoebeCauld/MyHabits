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
    init(color: UIColor, colorName: String){
        super.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        backgroundColor = color
        accessibilityIdentifier = colorName
        layer.cornerRadius = 0.5 * self.bounds.size.width
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func button(color: UIColor, colorName: String) -> UIButton{
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
//        backgroundColor = color
//        accessibilityIdentifier = colorName
//        layer.cornerRadius = 0.5 * self.bounds.size.width
//        clipsToBounds = true
//        return button
//    }
}
