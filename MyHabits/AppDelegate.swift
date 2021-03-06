//
//  AppDelegate.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit
import UserNotifications
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = AppDelegate()
//    let notifications = NotificationsManager()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        UserDefaults.standard.setValue(now.day, forKey: "today")
        setTodayValueFirstTimeFrom(now)
        checkIfNewDayStarts()
        NotificationsManager.shared.notificationsCenter.delegate = NotificationsManager.shared
//        notifications.notificationsCenter.delegate = notifications
        return true
    }

    fileprivate func setTodayValueFirstTimeFrom(_ now: DateComponents) {
        if UserDefaults.standard.bool(forKey: "didLaunchBefore") == false {
            // only runs the first time your app is launched
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            let now = Calendar.current.dateComponents(in: .current, from: Date())
            UserDefaults.standard.setValue(now.day, forKey: "today")
            // sets the initial value for tomorrow
            let tomorrow = DateComponents(year: now.year,
                                          month: now.month,
                                          day: now.day! + 1,
                                          hour: 0,
                                          minute: 0,
                                          second: 0)
            UserDefaults.standard.set(tomorrow.day, forKey: "tomorrow")
        }
    }

    fileprivate func checkIfNewDayStarts() {
        if UserDefaults.standard.object(forKey: "tomorrow") != nil {
            // makes sure tomorrow is not nil
            // check if today and tommorow is one day, which mean that the nex day came
            guard let today = UserDefaults.standard.object(forKey: "today") as? Int else { return }
            guard let tommorow = UserDefaults.standard.object(forKey: "tomorrow") as? Int else { return }
            if today >= tommorow {
                // set new value for days
                let now = Calendar.current.dateComponents(in: .current, from: Date())
                UserDefaults.standard.setValue(now.day, forKey: "today")
                let tomorrow = DateComponents(year: now.year,
                                              month: now.month,
                                              day: now.day! + 1,
                                              hour: 0,
                                              minute: 0,
                                              second: 0)
                UserDefaults.standard.set(tomorrow.day, forKey: "tomorrow")
                NotificationsManager.shared.isNewDay = true
            } else {
                NotificationsManager.shared.isNewDay = false
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyHabbits")
        container.loadPersistentStores(completionHandler: { (_ storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
