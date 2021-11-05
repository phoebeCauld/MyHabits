//
//  TabBarController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    private let listVC = ViewController()
    private let calendarVC = CalendarViewController()
    private let progressVC = ProgressViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTabBar()
        self.delegate = self
        
    }
    
    private func setNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        let tabBaritem = UITabBarItem()
        navigationVC.tabBarItem = tabBaritem
        tabBaritem.title = title
        tabBaritem.image = image
        return navigationVC
    }

    private func configurationTabBar(){
        tabBar.tintColor = Constants.Colors.defaultColor
        tabBar.unselectedItemTintColor = .lightGray
        viewControllers = [setNavigationVC(rootViewController: listVC, title: "My Habits", image: Constants.ImageLabels.listImage!),
                           setNavigationVC(rootViewController: calendarVC, title: "Calendar", image: Constants.ImageLabels.calendarImage!),
                           setNavigationVC(rootViewController: progressVC, title: "Progress", image: Constants.ImageLabels.progressImage!)]
    }

}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
