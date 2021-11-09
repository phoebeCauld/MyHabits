//
//  AddHabitViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class AddHabitViewController: UIViewController {
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private let addView = AddHabitView()
    private let coreData = ManageCoreData()
    private var selectLogic = SelectLogic()
    private var habits = [Habbit]()
    private var daysToRemind = [DaysToRemind]()
    private var newName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addView.tableView)
        setDelegates()
        configNavBar()
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
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
        
        let newHabit = Habbit(context: coreData.context)
        let selectedColor = selectLogic.selectedColor
        newHabit.title = name
        newHabit.labelColor = selectedColor
        newHabit.timeToRemind = selectLogic.selectedTimeToRemind
        let selectedDays = selectLogic.arrayOfSelected()
        for day in selectedDays {
            //                let notificationDay = selectLogic.createDate(weekday: day, hour: 21, minute: 09, year: 2021)
            //                appDelegate?.scheduleNotification(at: notificationDay, notificationType: name, identifier: name + "\(day)")
            let newDay = DaysToRemind(context: self.coreData.context)
            newDay.days = Int16(day)
            newDay.parentHabit = newHabit
            daysToRemind.append(newDay)
        }
        coreData.saveData()
        navigationController?.popViewController(animated: true)
    }

    @objc func setTimeToRemind(_ timePicker: UIDatePicker){
        selectLogic.selectedTimeToRemind = timePicker.date
    }
    
    @objc func setOnSwitch(_ mySwitch: UISwitch){
        addView.tableView.reloadData()
    }
    
    func enterTextAlert(){
        let alert = UIAlertController(title: "Empty name!", message: "Please, enter the name of your new habit", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
            cell.nameTextField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.daysCellIdentifier,
                                                         for: indexPath) as! DaysTableViewCell
            cell.selectionStyle = .none
            return cell
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                         for: indexPath) as! NotificationTableViewCell
            cell.selectionStyle = .none
            cell.notificationPicker.addTarget(self, action: #selector(setTimeToRemind), for: .valueChanged)
            cell.addNotificationSwitch.addTarget(self, action: #selector(setOnSwitch), for: .valueChanged)
            return cell
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.colorCellIdentifier,
                                                         for: indexPath) as! ColorTableViewCell
            cell.selectionStyle = .none
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
