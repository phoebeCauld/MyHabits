//
//  AllHabitsViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 04.12.2021.
//

import UIKit

class AllHabitsViewCell: UICollectionViewCell {

    var currentHabit: Habit! {
        didSet {
            habitName.text = currentHabit.title
            if let time = currentHabit.timeToRemind {
                let dateformat = DateFormatter()
                dateformat.dateFormat = "HH:mm"
                timeLabel.text = dateformat.string(from: time)
                clockImage.isHidden = false
            } else {
                timeLabel.text = ""
                clockImage.isHidden = true
            }

            if let daysArray = currentHabit.daysArray?.value(forKey: "days") as? Set<Int> {
                let days = Array(daysArray).sorted()
                setDaysToCalendarImage(days: days)
            }
            if currentHabit.isSelected {
                checkMark.isHidden = false
                checkMark.image = UIImage(systemName: "checkmark.circle")
            } else {
                checkMark.isHidden = true
            }
        }
    }

    let habitName: UILabel = {
        let name = UILabel()
        name.font = .boldSystemFont(ofSize: 20)
        name.numberOfLines = 3
        name.text = "Name of HAbit"
        return name
    }()

    let daysLabel: UILabel = {
        let name = UILabel()
        name.text = "every mon, sat, sun"
        return name
    }()

    let calendarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()

    let timeLabel: UILabel = {
        let name = UILabel()
        name.text = ""
        return name
    }()
    let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()

    let checkMark: UIImageView = {
        let checkMark = UIImageView()
        checkMark.image = UIImage(systemName: "circle")
        checkMark.tintColor = .black
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkMark.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return checkMark
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        setConstraints()
    }

    func setConstraints() {
        let timeStack = UIStackView(arrangedSubviews: [clockImage, timeLabel])
        timeStack.spacing = 8
        let daysStack = UIStackView(arrangedSubviews: [calendarImage, daysLabel])
        daysStack.spacing = 8
        let stack = CellStack.addStack(with: [habitName, timeStack, daysStack], contentView)
        contentView.addSubview(checkMark)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            checkMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }

    fileprivate func setDaysToCalendarImage(days: [Int]) {
        var daysString = ""
        if days.count == 7 {
            daysString = LocalizedString.everyDay
        } else if days.isEmpty {
            daysString = ""
            calendarImage.isHidden = true
        } else {
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
            calendarImage.isHidden = false
        }
        daysLabel.text = daysString
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
