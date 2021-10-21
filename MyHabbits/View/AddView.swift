//
//  AddView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AddView: UIView {

    let name: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        tf.leftViewMode = UITextField.ViewMode.always
        tf.leftView = spacerView
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 0.5
        let habbits = ["Drink water", "Workout", "Eat vegetables", "Go for a walk"]
        tf.placeholder = habbits.randomElement()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    func setView(_ view: UIView){
        view.backgroundColor = .systemBackground
        [name,nameTextField].forEach{view.addSubview($0)}
        setConstraints(view)
    }
    
    private func setConstraints(_ view: UIView){
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                          constant: 20),
            nameTextField.topAnchor.constraint(equalTo: name.bottomAnchor,
                                               constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

}
