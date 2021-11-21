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
    private var habbits = [Habit]()
    private var done: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
//        ManageCoreData.shared.loadData(usersHabbits: &habbits)
        ManageCoreData.shared.loadHabits(habit: &habbits)
        listView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        ManageCoreData.shared.loadData(usersHabbits: &habbits)
        ManageCoreData.shared.loadHabits(habit: &habbits)

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
        return habbits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainViewCellIdentifier, for: indexPath) as! HabbitsCell
        cell.selectionStyle = .none
        
        let text = habbits[indexPath.row].title
        cell.title.text = text
        
        let color = habbits[indexPath.row].labelColor
        switch color {
        case "pink": cell.cellView.backgroundColor = Constants.Colors.pink
        case "blue": cell.cellView.backgroundColor = Constants.Colors.blue
        case "orange": cell.cellView.backgroundColor = Constants.Colors.orange
        case "green": cell.cellView.backgroundColor = Constants.Colors.green
        default: cell.cellView.backgroundColor = Constants.Colors.defaultColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AddHabitViewController()
        detailVC.habit = habbits[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        NotificationsManager.shared.deleteNotificiation(with: habbits[indexPath.row].identifier?.uuidString ?? "")
        ManageCoreData.shared.deleteItem(at: indexPath, habit: &habbits)
        ManageCoreData.shared.saveData()
        tableView.reloadData()
    }
}
