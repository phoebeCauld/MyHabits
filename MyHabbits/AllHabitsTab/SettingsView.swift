//
//  SettingsView.swift
//  MyHabits
//
//  Created by F1xTeoNtTsS on 19.12.2021.
//

import UIKit

struct SettingsOptions {
    let title: String
    let Image: UIImage
}

fileprivate let cellID = "settingsCell"

class SettingsView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(SettingsViewCell.self, forCellReuseIdentifier: cellID)
        self.delegate = self
        self.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    let options = [SettingsOptions(title: "Edit", Image: Constants.ImageLabels.editImage ?? .actions),
                   SettingsOptions(title: "Delete", Image: Constants.ImageLabels.trashImage ?? .remove)]
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingsViewCell
        cell.settingsOptions = options[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: print("edit")
        default: print("delete")
        }
    }
}
