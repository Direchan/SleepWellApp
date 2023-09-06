//
//  MainTabBarController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/06.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePageViewController = HomePageViewController()
        let timerViewController = TimerViewController()
        let likePageViewController = LikePageViewController()
        
        homePageViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        timerViewController.tabBarItem = UITabBarItem(title: "Timer", image: nil, tag: 1)
        likePageViewController.tabBarItem = UITabBarItem(title: "Likes", image: nil, tag: 2)
        
        let tabBarList = [homePageViewController, timerViewController, likePageViewController]
        
        viewControllers = tabBarList
        
    }
}
