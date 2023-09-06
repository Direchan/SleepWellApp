//
//  MainTabBarController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarAppearance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupInitialTab()
        setupTabBarItemAppearance()
    }
    
    
    private func setupTabBarAppearance() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .deepIndigo?.withAlphaComponent(1.0)
        tabBar.tintColor = .pastelYellow
    }
    
    private func setupViewControllers() {
        let homePageViewController = HomePageViewController()
        let timerPageViewController = TimerPageViewController()
        let likePageViewController = LikePageViewController()
        
        homePageViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        timerPageViewController.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.fill"), tag: 1)
        likePageViewController.tabBarItem = UITabBarItem(title: "찜", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarList = [homePageViewController, timerPageViewController, likePageViewController]
        viewControllers = tabBarList
    }
    
    private func setupInitialTab() {
        self.selectedIndex = 1
    }
    
    private func setupTabBarItemAppearance() {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}


extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
