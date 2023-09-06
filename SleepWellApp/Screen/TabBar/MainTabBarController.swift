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
        
        homePageViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        timerViewController.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.fill"), tag: 1)
        likePageViewController.tabBarItem = UITabBarItem(title: "찜", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        let tabBarList = [homePageViewController, timerViewController, likePageViewController]
        
        viewControllers = tabBarList
                
        tabBar.isTranslucent = false

        
        // 탭바 배경색 설정
        tabBar.barTintColor = .deepIndigo?.withAlphaComponent(1.0)
        
        // 탭바 아이템 노랑색으로 활성화
        tabBar.tintColor = .pastelYellow
        
        // 글자 크기 조정
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
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
    }
}
