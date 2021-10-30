//
//  AddView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AddView: UIView {
    let dayButton = DaysButton()
    let colorButton = SelectColorButtons()
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
    
    let chooseDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Click on day to remind"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let daysStack: UIStackView = {
        let daysStack = UIStackView()
        daysStack.axis = .horizontal
        daysStack.spacing = 5
        daysStack.distribution = .fillEqually
        daysStack.translatesAutoresizingMaskIntoConstraints = false
        return daysStack
    }()
    
    let selectColorLabel:UILabel = {
        let label = UILabel()
        label.text = "Select label color"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let colorsStack: UIStackView = {
        let colorsStack = UIStackView()
        colorsStack.axis = .horizontal
        colorsStack.spacing = 15
        colorsStack.distribution = .fillEqually
        colorsStack.translatesAutoresizingMaskIntoConstraints = false
        return colorsStack
    }()
    

    func setView(_ view: UIView){
        view.backgroundColor = .systemBackground
        [name,nameTextField,chooseDayLabel,daysStack,selectColorLabel,colorsStack].forEach{view.addSubview($0)}
        setConstraints(view)
    }
    
    private func setConstraints(_ view: UIView){
        let arrayOfButtons = dayButton.createButtons()
        for button in arrayOfButtons {
            daysStack.addArrangedSubview(button)
        }
        let arrayOfColors = colorButton.createColorButtons()
        for button in arrayOfColors {
            colorsStack.addArrangedSubview(button)
        }
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                     constant: 20),
            name.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                          constant: 20),
            nameTextField.topAnchor.constraint(equalTo: name.bottomAnchor,
                                               constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            chooseDayLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                                constant: 20),
            chooseDayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 20),
            daysStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            daysStack.topAnchor.constraint(equalTo: chooseDayLabel.bottomAnchor,
                                           constant: 10),
            daysStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 20),
            daysStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20),
            daysStack.heightAnchor.constraint(equalToConstant: 45),
            
            selectColorLabel.topAnchor.constraint(equalTo: daysStack.bottomAnchor,
                                                  constant: 20),
            selectColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 20),
            
            colorsStack.topAnchor.constraint(equalTo: selectColorLabel.bottomAnchor,
                                             constant: 10),
            colorsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 20),
            colorsStack.heightAnchor.constraint(equalToConstant: 45),
            colorsStack.widthAnchor.constraint(equalTo: colorsStack.heightAnchor, multiplier: 5)
            
        ])
    }
    

}
