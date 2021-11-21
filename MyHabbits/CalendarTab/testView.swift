//
//  testView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 21.11.2021.
//

import UIKit

class testView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupView(_ view: UIView) {
        view.addSubview(tableView)
        setConstraints(view)
    }
    
    private func setConstraints(_ view: UIView){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
