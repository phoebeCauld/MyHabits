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
        if let time = habit.timeToRemind {
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH:mm"
            cell.timeLabel.text = dateformat.string(from: time)
            cell.clockImage.isHidden = false
        } else {
            cell.timeLabel.text = ""
            cell.clockImage.isHidden = true
        }
        
        if let daysArray = habit.daysArray?.value(forKey: "days") as? Set<Int>{
            let days = Array(daysArray).sorted()
            var daysString = ""
            if days.count == 7 {
                daysString = LocalizedString.everyDay
            } else if days.isEmpty {
                daysString = ""
                cell.calendarImage.isHidden = true
            }else  {
                for day in days {
                    switch day {
                    case 1: daysString.append(LocalizedString.mon + ",")
                    case 2: daysString.append(LocalizedString.tue + ",")
                    case 3: daysString.append(LocalizedString.wed + ",")
                    case 4: daysString.append(LocalizedString.thu + ",")
                    case 5: daysString.append(LocalizedString.fri + ",")
                    case 6: daysString.append(LocalizedString.sat + ",")
                    case 7: daysString.append(LocalizedString.sun + ",")
                    default: daysString.append(" ")
                    }
                }
                daysString.removeLast()
                cell.calendarImage.isHidden = false
            }
            cell.daysLabel.text = daysString
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let addVC = AddHabitViewController()
        let currentHabit = habits[indexPath.item]
        addVC.habit = currentHabit
        navigationController?.pushViewController(addVC, animated: true)
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

