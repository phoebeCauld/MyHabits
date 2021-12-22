//
//  TabBarController.swift
//  MyHabbits
//
//  Created by F1xTeoNtTsS on 20.10.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    let todayHabbits = TodayHabitsViewController()
    private let allHabbitsVC = AllHabitsViewController()
    private let middleButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .lightGray
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        UIView().layoutIfNeeded()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTabBar()
        self.delegate = self
        
    }
    
    @objc private func addPressed(){
        let addVC = AddHabitViewController()
        let navController = UINavigationController(rootViewController: addVC)
        addVC.dismissCompletion = {
            ManageCoreData.shared.loadData(usersHabbits: &self.allHabbitsVC.habits)
            self.allHabbitsVC.collectionView.reloadData()
        }
//        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
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
        viewControllers = [
            setNavigationVC(rootViewController: allHabbitsVC, title: LocalizedString.allHabits, image: Constants.ImageLabels.listImage!),
            setNavigationVC(rootViewController: todayHabbits, title: LocalizedString.todayHabits, image: Constants.ImageLabels.calendarImage!)
                           ]
        middleButton.frame = CGRect(x: (view.frame.width/2)-25, y: -20, width: 60, height: 60)
        tabBar.addSubview(middleButton)
    }

}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
