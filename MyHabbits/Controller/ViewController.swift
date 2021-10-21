//
//  ViewController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let listView = ListView()
    private var habbits = [Habbit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.setupView(view)
        setDelegates()
        configNavBar()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
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
        navigationController?.pushViewController(addVC, animated: true)
    }
    
   //MARK: - Core Data Methods
    
    func save(){
        do {
            try context.save()
        } catch let error as NSError {
            print("failed with saving data: \(error.localizedDescription)")
        }
    }
    
    func loadData(){
        let request: NSFetchRequest<Habbit> = Habbit.fetchRequest()
        
        do {
            habbits = try context.fetch(request)
            print("data is loaded")
        } catch let error as NSError {
            print("failed with fetch request: \(error.localizedDescription)")
        }
        listView.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habbits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! HabbitsCell
        cell.title.text = habbits[indexPath.row].title
        cell.checkGoal.text = "1/10"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
