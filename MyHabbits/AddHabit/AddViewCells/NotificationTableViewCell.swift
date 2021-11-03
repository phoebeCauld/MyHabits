//
//  NotificationTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    private let addNotification = AddViewLabel(title: "Send me notification to remind")
    
    let addNotificationSwitch: UISwitch = {
       let notificationSwitch = UISwitch()
        return notificationSwitch
    }()
    
    let notificationPicker: UIDatePicker = {
       let picker = UIDatePicker()
        return picker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(_ view: UIView){
        let switchStack = UIStackView(arrangedSubviews: [addNotification, addNotificationSwitch])
        switchStack.axis = .horizontal
        switchStack.spacing = 10
        switchStack.alignment = .center
        switchStack.translatesAutoresizingMaskIntoConstraints = false

        let cellStack = CellStack.addStack(with: [switchStack], view)
        
        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 20),
            cellStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            cellStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            cellStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -20)
        ])
    }
}
