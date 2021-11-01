//
//  AddView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AddView: UIView {
    let dayButton = DaysButton()
    
    let name = AddViewLabel(title: "I want to start:")
    let chooseDayLabel = AddViewLabel(title: "Click on day to remind")
    let selectColorLabel = AddViewLabel(title: "Select label color")
    let addNotification = AddViewLabel(title: "Send me notification to remind")
    
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
    
    let daysStack: UIStackView = {
        let daysStack = UIStackView()
        daysStack.axis = .horizontal
        daysStack.spacing = 5
        daysStack.distribution = .fillEqually
        daysStack.translatesAutoresizingMaskIntoConstraints = false
        return daysStack
    }()
    
    let addNotificationSwitch: UISwitch = {
       let notificationSwitch = UISwitch()
        return notificationSwitch
    }()
    
    let notificationPicker: UIDatePicker = {
       let picker = UIDatePicker()
        
        return picker
    }()
    
 //Create color buttons
    let pinkButton: ColorButton = {
        let button = ColorButton(color: Constants.Colors.pink,colorName: "pink")
        return button
    }()
    let blueButton: ColorButton = {
            let button = ColorButton(color: Constants.Colors.blue, colorName: "blue")
        return button
    }()
    let orangeButton: ColorButton = {
        let button = ColorButton(color: Constants.Colors.orange, colorName: "orange")
        return button
    }()
    let greenButton: ColorButton = {
        let button = ColorButton(color: Constants.Colors.green, colorName: "green")
        return button
    }()

    
    func setView(_ view: UIView){
        view.backgroundColor = .systemBackground
        [name,nameTextField,chooseDayLabel,daysStack,selectColorLabel].forEach{view.addSubview($0)}
        setConstraints(view)
    }
    
    private func setConstraints(_ view: UIView){
        let arrayOfButtons = dayButton.createButtons()
        for button in arrayOfButtons {
            daysStack.addArrangedSubview(button)
        }
        let notificationStack = UIStackView(arrangedSubviews: [addNotification, addNotificationSwitch])
        notificationStack.axis = .horizontal
        notificationStack.spacing = 10
        notificationStack.alignment = .center
        notificationStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationStack)

        let colorsStack = UIStackView(arrangedSubviews: [pinkButton,blueButton,orangeButton,greenButton])
        colorsStack.axis = .horizontal
        colorsStack.spacing = 15
        colorsStack.distribution = .fillEqually
        colorsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorsStack)

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
            
            notificationStack.topAnchor.constraint(equalTo: daysStack.bottomAnchor,
                                                  constant: 20),
            notificationStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: 20),
            notificationStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -20),
            notificationStack.heightAnchor.constraint(equalToConstant: 50),
            
            
            selectColorLabel.topAnchor.constraint(equalTo: notificationStack.bottomAnchor,
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
