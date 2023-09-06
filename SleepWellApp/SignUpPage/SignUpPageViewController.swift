//
//  SignUpPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class SignUpPageViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    let logoImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

    
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //가로위치
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -320), //세로위치
                logoImageView.widthAnchor.constraint(equalToConstant: 132),  // 원하는 너비로 설정
                logoImageView.heightAnchor.constraint(equalToConstant: 45)  // 원하는 높이로 설정
            ])
    }
    


}
