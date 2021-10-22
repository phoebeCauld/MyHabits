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
    private var habbits = [NSManagedObject]()
    private let coreData = CoreData()
    
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
        let addVC = AddViewController()
        addVC.navigationItem.largeTitleDisplayMode = .never
        addVC.completion = { title, date in
            DispatchQueue.main.async {
                self.coreData.loadData(usersHabbits: &self.habbits)
                self.listView.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(addVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habbits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! HabbitsCell
        let text = habbits[indexPath.row].value(forKey: "title") as? String
        cell.title.text = text
        cell.checkGoal.text = "1/10"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
