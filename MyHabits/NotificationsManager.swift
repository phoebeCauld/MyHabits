//
//  Notifications.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 12.11.2021.
//

import UIKit
import UserNotifications

class NotificationsManager: NSObject, UNUserNotificationCenterDelegate {

    static let shared = NotificationsManager()
    var isNewDay: Bool = false
    let notificationsCenter = UNUserNotificationCenter.current()
    var notifications = [Notification]()

    // проверка на наличие всех уведомлений
    func listScheduledNotifications() {
        notificationsCenter.getPendingNotificationRequests(completionHandler: {requests -> Void in
            print("\(requests.count) requests -------")
            for request in requests {
                print(request.identifier)
            }
        })
        notificationsCenter.getDeliveredNotifications(completionHandler: {deliveredNotifications -> Void in
            print("\(deliveredNotifications.count) Delivered notifications-------")
            for notification in deliveredNotifications {
                print(notification.request.identifier)
            }
        })
    }

    func requestAuthorization() {
        notificationsCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("failed with: \(error.localizedDescription)")
            } else if !granted {
                print("User notifications are not enabled. Please enable in settings")
            } else {
                self.scheduleNotifications()
            }
        }
    }

    func scheduleNotification(for habit: Habit, day: Int, dayId: String) {
        guard let identifier = habit.identifier, let timeToRemind = habit.timeToRemind else { return }
        let title = "MyHabits"
        var dateTime = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: timeToRemind)
        dateTime.weekday = day
        let id = identifier.uuidString + dayId
        notifications.append(Notification(identifier: id,
                                          title: title,
                                          dayToRemind: dateTime))
        print(notifications)
        schedule()
    }

    private func schedule() {
        notificationsCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                self.requestAuthorization()
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }

    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = LocalizedString.notificationBody + notification.title
            content.sound = .default

            // если тест
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            // если не тест
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.dayToRemind, repeats: false)

            let request = UNNotificationRequest(identifier: notification.identifier,
                                                content: content,
                                                trigger: trigger)
            // удалить после тестов!!!!!

            //            notificationsCenter.removeAllPendingNotificationRequests()

            notificationsCenter.add(request) { error in
                if let error = error {
                    print("notification request failed with\(error.localizedDescription)")
                }
            }
        }
    }

    func deleteNotificiation(with id: String, daysIds: [String]) {
        for dayId in daysIds {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id + dayId])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id + dayId])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        completionHandler([.banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "local notification" {
            print("now you can do smthng with it")
        }
        completionHandler()
    }
}
