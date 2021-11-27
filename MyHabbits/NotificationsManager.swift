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
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        })
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: {deliveredNotifications -> () in
                    print("\(deliveredNotifications.count) Delivered notifications-------")
                    for notification in deliveredNotifications{
                        print(notification.request.identifier)
                    }
                })
    }
    
    func schedule() {
        notificationsCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
    
    func requestAuthorization(){
        notificationsCenter.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if let error = error {
                print("failed with: \(error.localizedDescription)")
            } else if !granted {
                NSLog("User notifications are not enabled. Please enable in settings")
            } else {
                self.scheduleNotifications()
            }
        }
    }

    
    func scheduleNotification(for habit: Habit, day: Int, dayId: String){
        guard let identifier = habit.identifier, let title = habit.title, let timeToRemind = habit.timeToRemind else { return }
        var dateTime = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: timeToRemind)
        dateTime.weekday = day
        let id = identifier.uuidString + dayId
        notifications.append(Notification(identifier: id,
                                          title: title,
                                          dayToRemind: dateTime))
        print(notifications)
        schedule()
        
    }
    
    func scheduleNotifications(){
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = "Don't forget to " + notification.title
            content.sound = .default
            
        //если тест
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
    
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "local notification" {
            print("now you can do smthng with it")
        }
        completionHandler()
    }
}

struct Notification {
    var identifier: String
    var title: String
    var dayToRemind: DateComponents
}
