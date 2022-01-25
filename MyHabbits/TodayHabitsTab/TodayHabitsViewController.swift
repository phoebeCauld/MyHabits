//
//  ViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import CoreData

class TodayHabitsViewController: UIViewController {

    private let listView = ListView()
    private let habitModel = HabitViewModel()
    private var habits = [Habit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        habitModel.currentdayCheck(for: habits, isNewDay: NotificationsManager.shared.isNewDay)
        listView.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadTodayHabits(habit: &habits)
        listView.tableView.reloadData()
    }

    private func setDelegates() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }

    private func configNavBar() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainViewCellIdentifier,
                                                 for: indexPath) as! HabbitsCell
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

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            self.habits[indexPath.row].isDone = !self.habits[indexPath.row].isDone
            ManageCoreData.shared.saveData()
            tableView.reloadData()
            }

        setColorByDoneStatus(indexPath, done)

        let config = UISwipeActionsConfiguration(actions: [done])
        return config
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: LocalizedString.deleteLabel) { (_, _, _) in
            self.deleteAction(tableView, indexPath)
        }
        let update = UIContextualAction(style: .normal, title: LocalizedString.editLabel) { (_, _, _) in
            let detailVC = AddHabitViewController()
            detailVC.habit = self.habits[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        delete.image = Constants.ImageLabels.trashImage
        update.backgroundColor = .systemYellow
        update.image = Constants.ImageLabels.editImage
        let config =  UISwipeActionsConfiguration(actions: [delete, update])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

    fileprivate func setColorByDoneStatus(_ indexPath: IndexPath, _ done: UIContextualAction) {
        switch self.habits[indexPath.row].isDone {
        case true: done.backgroundColor = .systemYellow
            done.image = UIImage(systemName: "arrow.uturn.backward")
        case false: done.backgroundColor = .systemGreen
            done.image = Constants.ImageLabels.doneImage
        }
    }

    fileprivate func  deleteAction(_ tableView: UITableView, _ indexPath: IndexPath) {
        let currentHabit = self.habits[indexPath.row]
        ManageCoreData.shared.deleteNotificationsFor(currentHabit)
        ManageCoreData.shared.deleteItem(at: indexPath, habit: &self.habits)
        ManageCoreData.shared.saveData()
        tableView.reloadData()
    }
}
