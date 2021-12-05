//
//  ViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private let listView = ListView()
    private var done: Bool = false
    private let habitModel = HabitViewModel()
    private var habits = [Habit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        ManageCoreData.shared.loadTodayHabits(habit: &habits)
        habitModel.currentdayCheck(for: habits, isNewDay: NotificationsManager.shared.isNewDay)
        listView.tableView.reloadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadTodayHabits(habit: &habits)
        listView.tableView.reloadData()
    }
    
    private func setDelegates(){
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    private func configNavBar(){
        navigationItem.title = LocalizedString.todayHabits
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - TableView methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainViewCellIdentifier, for: indexPath) as! HabbitsCell
        cell.selectionStyle = .none
        let text = habits[indexPath.row].title
        cell.title.text = text

        let color = habits[indexPath.row].labelColor
        cell.cellView.backgroundColor = habitModel.currentColorForHabit(with: color ?? "")
        habitModel.doneState(is: habits[indexPath.row].isDone, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let detailVC = AddHabitViewController()
            detailVC.habit = habits[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "Done") { (action, view, nil) in
            self.habits[indexPath.row].isDone = !self.habits[indexPath.row].isDone
            ManageCoreData.shared.saveData()
            tableView.reloadData()
            }

        done.backgroundColor = .systemGreen
        done.image = Constants.ImageLabels.doneImage
        let config = UISwipeActionsConfiguration(actions: [done])
        
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            if let daysId = self.habits[indexPath.row].daysArray?.value(forKey: "id") as? Set<String> {
                NotificationsManager.shared.deleteNotificiation(with: self.habits[indexPath.row].identifier?.uuidString ?? "", daysIds: Array(daysId))
            }
            
            ManageCoreData.shared.deleteItem(at: indexPath, habit: &self.habits)
            ManageCoreData.shared.saveData()
            tableView.reloadData()
        }
        delete.image = Constants.ImageLabels.trashImage
        let update = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            let detailVC = AddHabitViewController()
            detailVC.habit = self.habits[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        update.backgroundColor = .systemYellow
        update.image = Constants.ImageLabels.editImage
        let config =  UISwipeActionsConfiguration(actions: [delete, update])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

}
