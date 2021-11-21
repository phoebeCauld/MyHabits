//
//  CalendarView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class CalendarViewController: UIViewController {
    
    let tabView = testView()
    var habits = [Habit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.setupView(view)
        setDelegates()
        ManageCoreData.shared.loadData(usersHabbits: &habits)
    }
    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        tabView.tableView.reloadData()
    }
    private func setDelegates(){
        tabView.tableView.delegate = self
        tabView.tableView.dataSource = self
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = habits[indexPath.row].title
        return cell
    }
    
}
