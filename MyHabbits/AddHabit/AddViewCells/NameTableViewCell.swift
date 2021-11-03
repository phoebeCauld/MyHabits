//
//  NameTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    private let nameLabel = AddViewLabel(title: "I want to start:")
    
     let nameTextField: UITextField = {
        let tf = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        tf.leftViewMode = UITextField.ViewMode.always
        tf.leftView = spacerView
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 0.5
        let habbits = ["Drink water", "Workout", "Eat vegetables", "Go for a walk"]
        tf.placeholder = habbits.randomElement()
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints(contentView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
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
