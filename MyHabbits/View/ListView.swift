//
//  ShowView.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit

class ListView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HabbitsCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
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
