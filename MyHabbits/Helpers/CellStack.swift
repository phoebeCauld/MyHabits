//
//  CellStack.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import Foundation
import UIKit

struct CellStack {
    static func addStack(with subviews: [UIView], _ view: UIView) -> UIStackView {
        let cellStack = UIStackView(arrangedSubviews: subviews)
        cellStack.axis = .vertical
        cellStack.spacing = 10
        cellStack.alignment = .leading
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cellStack)
        return cellStack
    }
}

