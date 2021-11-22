//
//  Constants.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import Foundation
import UIKit

struct Constants {
    static let mainViewCellIdentifier = "Cell"
    static let sectoinsCellIdentifier = "sectoinCell"
    static let nameCellIdentifier = "nameCell"
    static let daysCellIdentifier = "daysCell"
    static let notificationCellIdentifier = "notificationCell"
    static let colorCellIdentifier = "colorCell"
    
    struct ImageLabels {
        static let calendarImage = UIImage(systemName: "calendar")
        static let listImage = UIImage(systemName: "list.bullet")
        static let progressImage = UIImage(systemName: "chart.line.uptrend.xyaxis")
        static let openImage = UIImage(systemName: "chevron.down")
        static let closeImage = UIImage(systemName: "chevron.up")
        static let checkImage = UIImage(systemName: "checkmark.circle")
        static let checkDoneImage = UIImage(systemName: "checkmark.circle.fill")
    }
    
    struct Colors {
        static let defaultColor: UIColor = .systemBlue
        static let pink: UIColor = UIColor(red: 0.97, green: 0.65, blue: 0.76, alpha: 1.00)
        static let blue: UIColor = UIColor(red: 0.47, green: 0.55, blue: 0.92, alpha: 1.00)
        static let orange: UIColor = UIColor(red: 0.98, green: 0.69, blue: 0.63, alpha: 1.00)
        static let green: UIColor = UIColor(red: 0.39, green: 0.80, blue: 0.85, alpha: 1.00)
    }
}
