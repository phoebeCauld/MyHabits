//
//  ViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import CoreData

struct HabitsSection {
    var title: String
    var habits: [Habit]
    var isOpened: Bool
}

class ViewController: UIViewController {
    
    private let listView = ListView()
    private var habbits = [HabitsSection]()
    private var done: Bool = false
    private let habitModel = HabitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        habbits = [HabitsSection(title: "Your tasks for today", habits: [Habit](), isOpened: true),
        HabitsSection(title: "All of your habits", habits: [Habit](), isOpened: false)]
        ManageCoreData.shared.loadHabits(habit: &habbits[0].habits)
        ManageCoreData.shared.loadData(usersHabbits: &habbits[1].habits)
        listView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadHabits(habit: &habbits[0].habits)
        ManageCoreData.shared.loadData(usersHabbits: &habbits[1].habits)
        listView.tableView.reloadData()
    }
    
    private func setDelegates(){
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    private func configNavBar(){
        navigationItem.title = "My Habits"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    
    @objc
    private func addButtonPressed(){
        let addVC = AddHabitViewController()
        addVC.navigationItem.largeTitleDisplayMode = .never
        addVC.title = "Add new habit"
        navigationController?.pushViewController(addVC, animated: true)
    }
   
    
}

// MARK: - TableView methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return habbits[section].habits.count + 1
        case 1: if habbits[section].isOpened {
            return habbits[section].habits.count + 1
        }
            return 1
        default : return 1
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return habbits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sectoinsCellIdentifier, for: indexPath) as! SectionCell
            cell.selectionStyle = .none
            
            let text = habbits[indexPath.section].title
            cell.sectionLabel.text = text
            if indexPath.section == 0 {
                cell.openImage.isHidden = true
            }
            switch habbits[indexPath.section].isOpened {
            case true: cell.openImage.image = Constants.ImageLabels.closeImage
            case false: cell.openImage.image = Constants.ImageLabels.openImage
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainViewCellIdentifier, for: indexPath) as! HabbitsCell
        cell.selectionStyle = .none
        
        let text = habbits[indexPath.section].habits[indexPath.row-1].title
        cell.title.text = text
        
        let color = habbits[indexPath.section].habits[indexPath.row-1].labelColor
        habitModel.currentColorForHabit(with: color ?? "", for: cell.cellView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            habbits[indexPath.section].isOpened = !habbits[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .automatic)
        } else {
            let detailVC = AddHabitViewController()
            detailVC.habit = habbits[indexPath.section].habits[indexPath.row-1]
            navigationController?.pushViewController(detailVC, animated: true)
        }


    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        NotificationsManager.shared.deleteNotificiation(with: habbits[indexPath.section].habits[indexPath.row-1].identifier?.uuidString ?? "")
//        ManageCoreData.shared.deleteItemInTwoDemensions(at: indexPath, habit: &habbits)
//        ManageCoreData.shared.saveData()
//        tableView.reloadData()
//    }
}
