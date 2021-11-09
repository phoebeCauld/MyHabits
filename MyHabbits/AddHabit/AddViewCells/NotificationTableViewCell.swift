//
//  NotificationTableViewCell.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 01.11.2021.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    private var isPickerHiden: Bool = true
    private let addNotification = AddViewLabel(title: "Send me notification to remind")
    
    let addNotificationSwitch: UISwitch = {
       let notificationSwitch = UISwitch()
        notificationSwitch.addTarget(self, action: #selector(changedSwitch), for: .valueChanged)
        return notificationSwitch
    }()
    
    let notificationPicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.timeZone = .current
        picker.isHidden = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var withPickerConstraints = [NSLayoutConstraint]()
    var withoutPickerConstraints = [NSLayoutConstraint]()
    
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
        view.addSubview(switchStack)
        view.addSubview(notificationPicker)
        
        withPickerConstraints = [
            notificationPicker.topAnchor.constraint(equalTo: switchStack.bottomAnchor,
                                                   constant: 10),
            notificationPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            notificationPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            notificationPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -10)
        ]
        withoutPickerConstraints = [
            switchStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: -20)
        ]
        
        NSLayoutConstraint.activate([
            switchStack.topAnchor.constraint(equalTo: view.topAnchor,
                                          constant: 20),
            switchStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            switchStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20)
        ] + withoutPickerConstraints)
    }
    
    private func setTimePicker(_ isHidden:Bool){
        if !isHidden, notificationPicker.superview != nil {
            withoutPickerConstraints.forEach{$0.isActive = false}
            withPickerConstraints.forEach{$0.isActive = true}
        }
        
        if !isHidden, notificationPicker.superview == nil {
            contentView.addSubview(notificationPicker)
            withoutPickerConstraints.forEach{$0.isActive = false}
            withPickerConstraints.forEach{$0.isActive = true}
        }
        if isHidden, notificationPicker.superview != nil {
            withoutPickerConstraints.forEach{$0.isActive = true}
            withPickerConstraints.forEach{$0.isActive = false}
            notificationPicker.removeFromSuperview()
        }
    }
    
    @objc func changedSwitch(_ mySwith: UISwitch){
        if mySwith.isOn {
            isPickerHiden = false
            notificationPicker.isHidden = false
            setTimePicker(isPickerHiden)
        } else {
            isPickerHiden = true
            notificationPicker.isHidden = true

            setTimePicker(isPickerHiden)
        }
    }

}
