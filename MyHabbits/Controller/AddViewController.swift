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
    var selectDay = SelectedDayLogic()
    var habits = [Habbit]()
    var daysToRemind = [DaysToRemind]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.setView(view)
        configNavBar()
    }
    
    private func configNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }

    
    @objc func doneButtonPressed(){
        guard let name = addView.nameTextField.text else { return }
        let newHabit = Habbit(context: coreData.context)
        let selectedDays = selectDay.arrayOfSelected()
        newHabit.title = name
        
        for day in selectedDays {
            let newDay = DaysToRemind(context: self.coreData.context)
            newDay.days = Int16(day)
            newDay.parentHabit = newHabit
            daysToRemind.append(newDay)
        }
        coreData.saveData()
        
    }
    
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
}
