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
    public var completion: ((String,Date) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.setView(view)
        configNavBar()
    }
    
    private func configNavBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }
    
    @objc func dayButtonPressed(_ sender: UIButton){
//        if sender.backgroundColor == .white {
//            sender.backgroundColor = .systemBlue
//        }
//        else if sender.backgroundColor == .systemBlue {
//            sender.backgroundColor = .white
//        }
    }
    
    @objc func doneButtonPressed(){
        guard let name = addView.nameTextField.text, addView.nameTextField.hasText else { return }
        let date = Date()
        completion?(name, date)
    }
}
