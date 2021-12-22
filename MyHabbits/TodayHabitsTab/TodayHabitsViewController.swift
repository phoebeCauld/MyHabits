//
//  ViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import CoreData

class TodayHabitsViewController: UIViewController {
    
    let listView = ListView()
    private var done: Bool = false
    private let habitModel = HabitViewModel()
    var habits = [Habit]()
    
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

extension TodayHabitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainViewCellIdentifier, for: indexPath) as! HabbitsCell
        cell.selectionStyle = .none
        let habit = habits[indexPath.row]
        cell.title.text = habit.title

        let color = habit.labelColor
        cell.cellView.backgroundColor = habitModel.currentColorForHabit(with: color ?? "")
        habitModel.doneState(is: habit.isDone, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let detailVC = AddHabitViewController()
            detailVC.habit = habits[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "") { (action, view, nil) in
            self.habits[indexPath.row].isDone = !self.habits[indexPath.row].isDone
            ManageCoreData.shared.saveData()
            tableView.reloadData()
            }
        
        switch self.habits[indexPath.row].isDone{
        case true: done.backgroundColor = .systemYellow
//            done.title = LocalizedString.undoneLabel
            done.image = UIImage(systemName: "arrow.uturn.backward")
        case false: done.backgroundColor = .systemGreen
//            done.title = LocalizedString.doneLabel
            done.image = Constants.ImageLabels.doneImage
        }
        
        let config = UISwipeActionsConfiguration(actions: [done])
        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: LocalizedString.deleteLabel) { (action, view, nil) in
            if let daysId = self.habits[indexPath.row].daysArray?.value(forKey: "id") as? Set<String> {
                NotificationsManager.shared.deleteNotificiation(with: self.habits[indexPath.row].identifier?.uuidString ?? "", daysIds: Array(daysId))
            }
            
            ManageCoreData.shared.deleteItem(at: indexPath, habit: &self.habits)
            ManageCoreData.shared.saveData()
            tableView.reloadData()
        }
        delete.image = Constants.ImageLabels.trashImage
        let update = UIContextualAction(style: .normal, title: LocalizedString.editLabel) { (action, view, nil) in
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
