//
//  Notifications.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 12.11.2021.
//

import UIKit
import UserNotifications

class NotificationsManager: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationsCenter = UNUserNotificationCenter.current()
    
    var notifications = [Notification]()
    
    
    // проверка на наличие всех уведомлений
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            for notification in notifications {
                print(notification)
            }
        }
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

    
    func scheduleNotification(for habit: Habit){
        guard let identifier = habit.identifier, let title = habit.title, let timeToRemind = habit.timeToRemind else { return }
        let dateTime = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: timeToRemind)
        
        notifications.append(Notification(identifier: identifier.uuidString,
                                          title: title,
                                          dayToRemind: dateTime))
        schedule()
        
    }
    
    func scheduleNotifications(){
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = "Don't forget to " + notification.title
            content.sound = .default
            
        //если тест
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
        // если не тест
        //let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: true)
        //request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            let request = UNNotificationRequest(identifier: notification.identifier,
                                                content: content,
                                                trigger: trigger)
//            notificationsCenter.removeAllPendingNotificationRequests()
            notificationsCenter.add(request) { error in
                if let error = error {
                    print("notification request failed with\(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteNotificiation(with id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])
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
