//
//  AddHabitView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class AddHabitView: UIView {

    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: Constants.nameCellIdentifier)
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: Constants.daysCellIdentifier)
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: Constants.notificationCellIdentifier)
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: Constants.colorCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    func setupView(_ view: UIView) {
        view.addSubview(tableView)
        setConstraints(view)
    }

    private func setConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
