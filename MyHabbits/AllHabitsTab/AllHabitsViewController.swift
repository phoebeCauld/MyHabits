//
//  CalendarView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AllHabitsViewController: UICollectionViewController {
    private let habitModel = HabitViewModel()
    private let habitCellId = "habitCellId"
    private var isEditingMode: Bool = false
    var habits = [Habit]()
    var selectedItems = [IndexPath]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AllHabitsViewCell.self, forCellWithReuseIdentifier: habitCellId)
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        configNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isEditingMode = false
        configNavBar()
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        collectionView.reloadData()
    }
    
    private func configNavBar(){
        navigationItem.title = LocalizedString.allHabits
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
    }

    @objc fileprivate func startEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(stopEditing))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItems))
        isEditingMode = true
    }
    
    @objc fileprivate func stopEditing() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
        navigationItem.leftBarButtonItem = nil
        isEditingMode = false
        if !selectedItems.isEmpty{
            for indexPath in selectedItems {
                habits[indexPath.item].isSelected = false
            }
            collectionView.reloadData()
        }
    }
    @objc fileprivate func deleteItems(){
        showDeleteAlert()
    }
    
    private func showDeleteAlert(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: LocalizedString.deleteLabel, style: .destructive) { _ in
            self.deleteHabit()
        }
        let cancelAction = UIAlertAction(title: LocalizedString.cancelLabel, style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func deleteHabit(){
        for indexPath in selectedItems.sorted(by: { $0.item > $1.item}){
            if habits[indexPath.item].isSelected {
                if let daysId = self.habits[indexPath.row].daysArray?.value(forKey: "id") as? Set<String> {
                    NotificationsManager.shared.deleteNotificiation(with: self.habits[indexPath.row].identifier?.uuidString ?? "", daysIds: Array(daysId))
                }
                ManageCoreData.shared.deleteItem(at: indexPath, habit: &self.habits)
                ManageCoreData.shared.saveData()
            }
        }
        selectedItems = []
        collectionView.reloadData()
        stopEditing()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellId, for: indexPath) as! AllHabitsViewCell
        let habit = habits[indexPath.item]
        cell.currentHabit = habit
        cell.backgroundColor = habitModel.currentColorForHabit(with: habit.labelColor ?? "")    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditingMode {
            let addVC = AddHabitViewController()
            let currentHabit = habits[indexPath.item]
            addVC.habit = currentHabit
            navigationController?.pushViewController(addVC, animated: true)
        } else {
            habits[indexPath.item].isSelected = true
            selectedItems.append(indexPath)
            collectionView.reloadData()
        }
    }
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension AllHabitsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width/2)-20
        return CGSize(width: width, height: width)
    }
}

extension AllHabitsViewController: UIGestureRecognizerDelegate {
    
}

