//
//  LoginPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class LoginPageViewController: UIViewController {

    lazy var loginButton: UIButton = {
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            button.center = view.center
            button.backgroundColor = .blue
            button.setTitle("Login", for: .normal)
            
            // loginButtonTapped 함수와 연결
            button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
            
            return button
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    

    @objc func loginButtonTapped() {
        // 로그인 로직 (성공 시)
        let mainTabBarController = MainTabBarController()
                UIApplication.shared.windows.first?.rootViewController = mainTabBarController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
}
