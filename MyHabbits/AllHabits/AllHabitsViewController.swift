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
    var habits = [Habit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AllHabitsViewCell.self, forCellWithReuseIdentifier: habitCellId)
        collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        configNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ManageCoreData.shared.loadData(usersHabbits: &habits)
        collectionView.reloadData()
    }
    
    private func configNavBar(){
        navigationItem.title = LocalizedString.allHabits
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellId, for: indexPath) as! AllHabitsViewCell
        let habit = habits[indexPath.item]
        cell.backgroundColor = habitModel.currentColorForHabit(with: habit.labelColor ?? "")
        cell.habitName.text = habit.title
        if let time = habit.timeToRemind{
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH:mm"
            cell.timeLabel.text = "Will remind at \(dateformat.string(from: time))"
        }
        return cell
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
