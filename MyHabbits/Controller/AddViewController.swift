//
//  AddViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    private let addView = AddView()
    private let coreData = ManageCoreData()
    private var selectDay = SelectedDayLogic()
    private var colorButtonLogic = SelectColorLogic()
    private var habits = [Habbit]()
    private var daysToRemind = [DaysToRemind]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.setView(view)
        addTargetToButtons()
        configNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
        guard let name = addView.nameTextField.text,
              addView.nameTextField.hasText
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
