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

        let nicknameField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "5글자 이내"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        let idField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "영문, 숫자 조합하여 6~12자"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        let passwordField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "영문, 숫자 조합하여 6~12자"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()


    
    
    

    override func viewDidLoad() {
        
        view.addSubview(nicknameField)
        view.addSubview(idField)
        view.addSubview(passwordField)

        super.viewDidLoad()

    
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            
            nicknameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            nicknameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            idField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idField.topAnchor.constraint(equalTo: nicknameField.bottomAnchor, constant: 20),
            idField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                
            
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //가로위치
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -320), //세로위치
                logoImageView.widthAnchor.constraint(equalToConstant: 132),  // 원하는 너비로 설정
                logoImageView.heightAnchor.constraint(equalToConstant: 45)  // 원하는 높이로 설정
            ])
    }
    



}
