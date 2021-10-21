//
//  AddViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AddViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let addView = AddView()
    private var habbits = [Habbit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.setView(view)
        configNavBar()
    }
    
    private func configNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }
    
    @objc func doneButtonPressed(){
        let newHabbit = Habbit(context: self.context)
        guard let name = addView.nameTextField.text else { return }
        newHabbit.title = name
        saveHabbit()     
    }
    
    private func saveHabbit(){
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed with saving data: \(error.localizedDescription)")
        }
    }

}
