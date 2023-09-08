//
//  ViewController.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/07.
//

import UIKit

class NavigationUtil {
    static var currentViewController: UIViewController?
    
    @objc static func openMyPage() {
        if let currentViewController = currentViewController {
            let myPageViewController = MyPageViewController()
            currentViewController.navigationController?.pushViewController(myPageViewController, animated: true)
        }
    }
    
    static func setupNavigationBar(for viewController: UIViewController) {
        let logoName = "Logo"
        let logo = UIImage(named: logoName)
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        let logoItem = UIBarButtonItem(customView: imageView)
        viewController.navigationController?.navigationBar.tintColor = .pastelYellow
        viewController.navigationItem.leftBarButtonItem = logoItem
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(openMyPage))
        rightButton.tintColor = .pastelYellow  // 버튼 색상 변경
        
        viewController.navigationItem.rightBarButtonItem = rightButton
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.pastelYellow!]
        viewController.navigationController?.navigationBar.standardAppearance = appearance
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

