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
        setupTabBarAppearance()
    }

    
    //탭바 모양과 색 설정
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .deepIndigo //배경색 설정
        tabBar.standardAppearance = appearance //기본 모양 설정
        tabBar.scrollEdgeAppearance = appearance //스크롤시 모양 설정
        tabBar.tintColor = .pastelYellow //아이콘 색
        
        setupInitialTab() // 초기 화면 설정
        setupViewControllers() //탭바 아이템 설정
        setupTabBarItemAppearance() //탭바 폰트
    }
    
    
    // 초기 화면 설정
    private func setupInitialTab() {
        self.selectedIndex = 0
    }
    
    
    //탭바 아이템 설정
    private func setupViewControllers() {
        let homePageViewController = HomePageViewController()
        let timerPageViewController = TimerPageViewController()
        let likePageViewController = LikePageViewController()
        
        let naviHomePageVC = UINavigationController(rootViewController: homePageViewController)
        let naviTimerPageVC = UINavigationController(rootViewController: timerPageViewController)
        let naviLikePageVC = UINavigationController(rootViewController: likePageViewController)

        
        
        homePageViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        timerPageViewController.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.fill"), tag: 1)
        likePageViewController.tabBarItem = UITabBarItem(title: "찜", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarList = [naviHomePageVC, naviTimerPageVC, naviLikePageVC]
        viewControllers = tabBarList
        
        
        
    }
    

    
    //탭바 폰트
    private func setupTabBarItemAppearance() {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}
