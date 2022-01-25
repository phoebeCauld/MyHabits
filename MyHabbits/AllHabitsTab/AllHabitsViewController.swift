//
//  CalendarView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.10.2021.
//

import UIKit

class AllHabitsViewController: UICollectionViewController {
    let cellEditManager = CellEditManager()
    var habits = [Habit]()
    private let habitModel = HabitViewModel()
    private var isEditingMode: Bool = false {
        didSet {
            configNavBar()
        }
    }
    private var selectedItems = [Habit: IndexPath]() {
        didSet {
            if isEditingMode {
                navigationItem.rightBarButtonItem?.isEnabled = !selectedItems.isEmpty
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AllHabitsViewCell.self, forCellWithReuseIdentifier: Constants.habitCellId)
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        addLongPressGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isEditingMode = false
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        collectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopEditing()
    }

    fileprivate func addLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(activateLongPressGesture))
        longPressGesture.minimumPressDuration = 0.3
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delegate = self
        self.view.addGestureRecognizer(longPressGesture)
    }

    @objc fileprivate func activateLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let currentIndexPath = gesture.location(in: self.collectionView)
        guard let indexPath = self.collectionView?.indexPathForItem(at: currentIndexPath) else { return }
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? AllHabitsViewCell else { return }

        if gesture.state == .began {
            HapsticsManager.shared.vibrate(for: .success)
        } else if gesture.state == .ended {
            startEditing()
            selectHabit(for: indexPath)
        }
        cellEditManager.transformCellFor(gesture.state, and: cell)
    }

    fileprivate func configNavBar() {
        navigationItem.title = LocalizedString.allHabits
        navigationController?.navigationBar.prefersLargeTitles = true

        if !isEditingMode {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                target: self,
                                                                action: #selector(startEditing))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(stopEditing))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                                target: self,
                                                                action: #selector(deleteItems))
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    @objc fileprivate func startEditing() {
        isEditingMode = true
    }

    @objc fileprivate func stopEditing() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(startEditing))
        navigationItem.leftBarButtonItem = nil
        isEditingMode = false
        if !selectedItems.isEmpty {
            unselectAllHabits()
        }
    }

    @objc fileprivate func deleteItems() {
        showDeleteAlert()
    }

    fileprivate func showDeleteAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: LocalizedString.deleteLabel, style: .destructive) { _ in
            self.deleteHabit()
        }
        let cancelAction = UIAlertAction(title: LocalizedString.cancelLabel, style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    fileprivate func deleteHabit() {
        let sortedItems = selectedItems.values.sorted(by: >)
        for indexPath in sortedItems {
            let currentHabit = habits[indexPath.row]
            ManageCoreData.shared.deleteNotificationsFor(currentHabit)
            ManageCoreData.shared.deleteItem(at: indexPath, habit: &self.habits)
            ManageCoreData.shared.saveData()
        }
        selectedItems = [:]
        collectionView.reloadData()
        stopEditing()
    }

    fileprivate func selectHabit(for indexPath: IndexPath) {
        habits[indexPath.item].isSelected = true
        selectedItems[habits[indexPath.item]] = indexPath
        self.collectionView.reloadData()
    }

    fileprivate func unselectAllHabits() {
        for (habit, _ ) in selectedItems {
            habit.isSelected = false
        }
        selectedItems = [:]
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habits.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.habitCellId,
                                                      for: indexPath) as! AllHabitsViewCell
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
            switch habits[indexPath.item].isSelected {
            case true: habits[indexPath.item].isSelected = false
                selectedItems[habits[indexPath.item]] = nil
            case false: habits[indexPath.item].isSelected = true
                selectedItems[habits[indexPath.item]] = indexPath
            }
            collectionView.reloadData()
        }
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension AllHabitsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width/2)-15
        return CGSize(width: width, height: width)
    }
}

extension AllHabitsViewController: UIGestureRecognizerDelegate {}
