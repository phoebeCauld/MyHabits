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
//    private var appDelegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        habbits = [HabitsSection(title: "Your tasks for today", habits: [Habit](), isOpened: true),
        HabitsSection(title: "All of your habits", habits: [Habit](), isOpened: false)]
        ManageCoreData.shared.loadTodayHabits(habit: &habbits[0].habits)
        ManageCoreData.shared.loadOtherHabits(habit: &habbits[1].habits)
        habitModel.currentdayCheck(for: habbits[0].habits, isNewDay: NotificationsManager.shared.isNewDay)
        habitModel.currentdayCheck(for: habbits[1].habits, isNewDay: NotificationsManager.shared.isNewDay)
        listView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadTodayHabits(habit: &habbits[0].habits)
        ManageCoreData.shared.loadOtherHabits(habit: &habbits[1].habits)
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
//            if indexPath.section == 0 {
//                cell.openImage.isHidden = true
//            }
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
        cell.cellView.backgroundColor = habitModel.currentColorForHabit(with: color ?? "")
        habitModel.doneState(is: habbits[indexPath.section].habits[indexPath.row-1].isDone, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//
            self.habbits[indexPath.section].isOpened = !self.habbits[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .fade)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)

            
        } else {
            let detailVC = AddHabitViewController()
            detailVC.habit = habbits[indexPath.section].habits[indexPath.row-1]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 { return nil }
        let done = UIContextualAction(style: .normal, title: "Done") { (action, view, nil) in
            self.habbits[indexPath.section].habits[indexPath.row-1].isDone = !self.habbits[indexPath.section].habits[indexPath.row-1].isDone
            ManageCoreData.shared.saveData()
            tableView.reloadData()
            }

        done.backgroundColor = .systemGreen
        done.image = Constants.ImageLabels.doneImage
        let config = UISwipeActionsConfiguration(actions: [done])

        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 { return nil }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            if let daysId = self.habbits[indexPath.section].habits[indexPath.row-1].daysArray?.value(forKey: "id") as? Set<String> {
                NotificationsManager.shared.deleteNotificiation(with: self.habbits[indexPath.section].habits[indexPath.row-1].identifier?.uuidString ?? "", daysIds: Array(daysId))
            }
            
            ManageCoreData.shared.deleteItemInTwoDemensions(at: indexPath, habit: &self.habbits)
            ManageCoreData.shared.saveData()
            tableView.reloadData()
        }
        delete.image = Constants.ImageLabels.trashImage
        let update = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            let detailVC = AddHabitViewController()
            detailVC.habit = self.habbits[indexPath.section].habits[indexPath.row-1]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        update.backgroundColor = .systemYellow
        update.image = Constants.ImageLabels.editImage
        let config =  UISwipeActionsConfiguration(actions: [delete, update])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

}
