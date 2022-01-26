//
//  NameTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    private let nameLabel = AddViewLabel(title: LocalizedString.nameLabel)

     let nameTextField: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        let habbits = [LocalizedString.placeholder1,
                        LocalizedString.placeholder2,
                        LocalizedString.placeholder3,
                        LocalizedString.placeholder4]
        textField.placeholder = habbits.randomElement()
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints(_ view: UIView) {
        let cellStack = CellStack.addStack(with: [nameLabel, nameTextField], view)
        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.widthAnchor.constraint(equalTo: cellStack.widthAnchor)
        ])
    }
}
