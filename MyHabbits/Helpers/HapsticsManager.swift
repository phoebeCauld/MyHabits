//
//  HapsticsManager.swift
//  MyHabits
//
//  Created by F1xTeoNtTsS on 24.12.2021.
//

import UIKit

final class HapsticsManager {
    static let shared = HapsticsManager()

    private init() {
    }

    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }

    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenrator = UINotificationFeedbackGenerator()
            notificationGenrator.prepare()
            notificationGenrator.notificationOccurred(type)
        }
    }
}
