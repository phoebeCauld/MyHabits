//
//  AddHabitViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    var habit: Habit?
    private let addView = AddHabitView()
    private var selectLogic = SelectLogic()
    private var newName: String?
    private var isReminding: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addView.tableView)
        setDelegates()
        configNavBar()
        setView()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addView.tableView.frame = view.bounds
    }
    
    private func setDelegates(){
        addView.tableView.delegate = self
        addView.tableView.dataSource = self
    }
    
    private func configNavBar(){
        var buttonName = ""
        if let _ = habit {
            buttonName = "Update"
        } else {
            buttonName = "Save"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonName, style: .done, target: self, action: #selector(saveButtonPressed))
    }
    
    // MARK: -  Actions with buttons
    
    @objc func dayButtonPressed(_ sender: UIButton){
        selectLogic.selectDay(sender)
    }
    
    @objc func selectColorsPressed(_ sender: UIButton){
        selectLogic.updateButtonStates(self, sender)
    }
    
    @objc func saveButtonPressed(){
        guard let name = newName
        else {
            return enterTextAlert()
        }
        if let habit = habit {
            selectLogic.updateHabit(habit: habit, name: name, isReminding: isReminding)
            ManageCoreData.shared.saveData()
        } else {
            selectLogic.addHabit(with: name, isRemindning: isReminding)
            ManageCoreData.shared.saveData()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func setTimeToRemind(_ timePicker: UIDatePicker){
        selectLogic.selectedTimeToRemind = timePicker.date
    }
    
    @objc func setOnSwitch(_ mySwitch: UISwitch){
        guard let habit = habit else { return }
        if mySwitch.isOn {
            isReminding = true
        } else {
            isReminding = false
        }        
        selectLogic.updateRemindSwitch(for: habit, isReminding: isReminding)
        addView.tableView.reloadData()
    }
    
    func enterTextAlert(){
        let alert = UIAlertController(title: "Empty name!", message: "Please, enter the name of your new habit", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func setView(){
        if let habit = habit {
            title = "Update: \(habit.title ?? "")"
        } else {
            title = "Add new habit"
        }
    }
    
}

extension AddHabitViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nameCellIdentifier,
                                                         for: indexPath) as! NameTableViewCell
            if let habit = habit {
                newName = habit.title ?? ""
                cell.nameTextField.text = habit.title ?? ""
            }
            cell.nameTextField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.daysCellIdentifier,
                                                         for: indexPath) as! DaysTableViewCell
            
            cell.selectionStyle = .none
            if let habit = habit {
                let selectedDaysArray = selectLogic.oldDaysArray(habit: habit)
                for button in selectedDaysArray {
                    selectLogic.selectOldDays(button, cell.arrayOfButtons[button-1])
                }
            }
            return cell
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                         for: indexPath) as! NotificationTableViewCell
            cell.selectionStyle = .none
            if let habit = habit {
                isReminding = habit.isRemindning
                cell.oldNotificationPickerState(habit, isReminding)
            }
            cell.notificationPicker.addTarget(self, action: #selector(setTimeToRemind), for: .valueChanged)
            cell.addNotificationSwitch.addTarget(self, action: #selector(setOnSwitch), for: .valueChanged)
            
            return cell
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.colorCellIdentifier,
                                                         for: indexPath) as! ColorTableViewCell
            cell.selectionStyle = .none
            if let habit = habit {
                selectLogic.selectedColor = habit.labelColor
                let colorArray = [cell.pinkButton,cell.blueButton,cell.greenButton,cell.orangeButton]
                for button in colorArray {
                    if button.accessibilityIdentifier == habit.labelColor {
                        button.layer.borderWidth = 1.5
                        button.isSelected = true
                    }
                }
            }
            return cell
        default: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                          for: indexPath) as! NotificationTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

extension AddHabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            newName = textField.text
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
