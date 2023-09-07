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
        let timerViewController = TimerPageViewController()
        let likePageViewController = LikePageViewController()
        
        homePageViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        timerViewController.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.fill"), tag: 1)
        likePageViewController.tabBarItem = UITabBarItem(title: "찜", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarList = [homePageViewController, timerViewController, likePageViewController]
        
        viewControllers = tabBarList
                
        // 탭바 배경색 설정
        tabBar.barTintColor = .deepIndigo
        
        // 탭바 아이템 노랑색으로 활성화
        tabBar.tintColor = .pastelYellow
        
        // 글자 크기 조정
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }


// UIColor를 UIImage로 변환하는 유틸리티
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

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBarAppearance()
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTabBarAppearance()
//    }
//
    
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
        self.selectedIndex = 1
    }
    
    
    //탭바 아이템 설정
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
    

    
    //탭바 폰트
    private func setupTabBarItemAppearance() {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}
