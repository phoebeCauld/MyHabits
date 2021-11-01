//
//  AddHabitViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class AddHabitViewController: UIViewController {
    private let addView = AddHabitView()
    private let coreData = ManageCoreData()
    private var selectDay = SelectedDayLogic()
    private var colorButtonLogic = SelectColorLogic()
    private var habits = [Habbit]()
    var newName: String?
    private var daysToRemind = [DaysToRemind]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addView.tableView)
        setDelegates()
        configNavBar()
        addTargetToButtons()
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
    
    private func addTargetToButtons(){
        let colorButtons = [addView.pinkButton, addView.greenButton,addView.orangeButton,addView.blueButton]
        colorButtons.forEach({$0.addTarget(self, action: #selector(selectColorsPressed), for: .touchUpInside)})
    }

    // MARK: -  Actions with buttons

        @objc func dayButtonPressed(_ sender: UIButton){
            sender.isSelected = !sender.isSelected
            let key = sender.tag
            selectDay.selectDay(key: key)
            if sender.isSelected{
                sender.backgroundColor = .systemBlue
                sender.setTitleColor(.white, for: .normal)
            }   else {
                sender.backgroundColor = .white
                sender.setTitleColor(.systemBlue, for: .normal)
            }
        }
        
        @objc func selectColorsPressed(_ sender: UIButton){
            colorButtonLogic.updateButtonStates([addView.pinkButton,
                                                 addView.blueButton,
                                                 addView.orangeButton,
                                                 addView.greenButton], sender)
            
        }
        
        @objc func saveButtonPressed(){
            guard let name = newName
            else {
                enterTextAlert()
                return
            }
            
            let newHabit = Habbit(context: coreData.context)
            let selectedColor = colorButtonLogic.selectedColor
            newHabit.title = name
            newHabit.labelColor = selectedColor
            
            let selectedDays = selectDay.arrayOfSelected()
            for day in selectedDays {
                let newDay = DaysToRemind(context: self.coreData.context)
                newDay.days = Int16(day)
                newDay.parentHabit = newHabit
                daysToRemind.append(newDay)
            }
            coreData.saveData()
            navigationController?.popViewController(animated: true)
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
            newName = cell.nameTextField.text
            return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.daysCellIdentifier,
                                                         for: indexPath) as! DaysTableViewCell
            return cell
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                         for: indexPath) as! NotificationTableViewCell
            return cell
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.colorCellIdentifier,
                                                         for: indexPath) as! ColorTableViewCell
            return cell
        default: let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notificationCellIdentifier,
                                                          for: indexPath) as! NotificationTableViewCell
            return cell
        }
        
    }

    
    
}
