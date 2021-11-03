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
    private var habbits = [Habbit]()
    private let coreData = ManageCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        coreData.loadData(usersHabbits: &habbits)
        listView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreData.loadData(usersHabbits: &habbits)
        listView.tableView.reloadData()
    }
    
    private func setDelegates(){
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
    }
    
    private func configNavBar(){
        navigationItem.title = "My Habbits"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    
    @objc
    private func addButtonPressed(){
        let addVC = AddHabitViewController()
        addVC.navigationItem.largeTitleDisplayMode = .never
        addVC.title = "Add new habbit"
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
        let text = habbits[indexPath.row].title
        let color = habbits[indexPath.row].labelColor
        switch color {
        case "pink": cell.cellView.backgroundColor = Constants.Colors.pink
        case "blue": cell.cellView.backgroundColor = Constants.Colors.blue
        case "orange": cell.cellView.backgroundColor = Constants.Colors.orange
        case "green": cell.cellView.backgroundColor = Constants.Colors.green
        default: cell.cellView.backgroundColor = Constants.Colors.defaultColor
        }
        cell.title.text = text
        if let daysArray = habbits[indexPath.row].daysArray?.count  {
            cell.checkGoal.text = "0/\(daysArray)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        coreData.deleteItem(at: indexPath, habit: &habbits)
        coreData.saveData()
        tableView.reloadData()
    }
}
