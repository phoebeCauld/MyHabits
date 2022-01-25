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
    var dismissCompletion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        addView.setupView(view)
        view.backgroundColor = .white
        setDelegates()
        configNavBar()
        setView()
        self.hideKeyboardWhenTappedAround()
    }

    private func setDelegates() {
        addView.tableView.delegate = self
        addView.tableView.dataSource = self
    }

    private func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(canselButtonPressed))
        if habit != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                target: self,
                                                                action: #selector(saveButtonPressed))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                target: self,
                                                                action: #selector(saveButtonPressed))
        }
    }

    // MARK: - Actions with buttons

    @objc func dayButtonPressed(_ sender: UIButton) {
        selectLogic.selectDay(sender)
    }

    @objc func selectColorsPressed(_ sender: UIButton) {
        selectLogic.selectColorButton(self, sender)
    }

    @objc func saveButtonPressed() {
        guard let name = newName
        else {
            return enterTextAlert()
        }
        if let habit = habit {
            selectLogic.updateHabit(habit: habit, name: name, isReminding: isReminding)
            ManageCoreData.shared.saveData()
            navigationController?.popViewController(animated: true)
        } else {
            selectLogic.addHabit(with: name, isRemindning: isReminding)
            ManageCoreData.shared.saveData()
            dismissCompletion?()
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func canselButtonPressed() {
        if habit != nil {
            navigationController?.popViewController(animated: true)
        } else {
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func setTimeToRemind(_ timePicker: UIDatePicker) {
        if habit != nil {
            selectLogic.selectedTimeToRemind = timePicker.date
        }
        selectLogic.selectedTimeToRemind = timePicker.date
    }

    @objc func setOnSwitch(_ mySwitch: UISwitch) {
        switch mySwitch.isOn {
        case true:  isReminding = true
        case false:  isReminding = false
        }
        addView.tableView.reloadData()
        guard let habit = habit else { return }
        selectLogic.updateRemindSwitch(for: habit, isReminding: isReminding)
        addView.tableView.reloadData()
    }

    private func enterTextAlert() {
        let alert = UIAlertController(title: LocalizedString.emptyNameLabel,
                                      message: LocalizedString.emptyNameDescription,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: LocalizedString.canselButton,
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func setView() {
        navigationItem.largeTitleDisplayMode = .never
        if let habit = habit {
            title = LocalizedString.updateTitle + (habit.title ?? "")
        } else {
            title = LocalizedString.addTitle
        }
    }

    @objc func textFieldDidChangeText(_ textField: UITextField) {
        if textField.hasText {
            guard let text = textField.text else { return }
            newName = text
        }
    }
}

extension AddHabitViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nameCellIdentifier,
                                                         for: indexPath) as! NameTableViewCell
            if let habit = habit {
                newName = habit.title ?? ""
                cell.nameTextField.text = habit.title ?? ""
            }
            cell.nameTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .allEditingEvents)
            cell.nameTextField.delegate = self
            cell.nameTextField.becomeFirstResponder()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.daysCellIdentifier,
                                                         for: indexPath) as! DaysTableViewCell

            cell.selectionStyle = .none
            if let habit = habit {
                let selectedDaysArray = selectLogic.oldDaysArray(habit: habit)
                for button in selectedDaysArray {
                    selectLogic.selectOldDays(button, cell.arrayOfButtons[button-1])
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                         for: indexPath) as! NotificationTableViewCell
            cell.selectionStyle = .none
            if let habit = habit {
                isReminding = habit.isRemindning
                cell.oldNotificationPickerState(habit, isReminding)
            }
            cell.notificationPicker.addTarget(self, action: #selector(setTimeToRemind), for: .valueChanged)
            cell.addNotificationSwitch.addTarget(self, action: #selector(setOnSwitch), for: .valueChanged)

            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.colorCellIdentifier,
                                                         for: indexPath) as! ColorTableViewCell
            cell.selectionStyle = .none
            if let habit = habit {
                selectLogic.selectedColor = habit.labelColor
                let colorArray = [cell.pinkButton, cell.blueButton, cell.greenButton, cell.orangeButton]
                for button in colorArray where button.accessibilityIdentifier == habit.labelColor {
                        button.layer.borderWidth = 1.5
                        button.isSelected = true
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
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
