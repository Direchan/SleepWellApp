//
//  MyPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class MyPageViewController: UIViewController {
    
    private lazy var bigBox: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.05)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "말하는감자"
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        return label
    }()
    
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "@test123"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        return label
    }()
    
    
    private lazy var changeNicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임변경", for: .normal)
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .deepIndigo
        button.layer.cornerRadius = 17.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.pastelYellow?.cgColor
        button.layer.cornerRadius = 17.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "마이페이지"
        view.backgroundColor = .indigo
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(bigBox)
        view.addSubview(logoutButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(spacerView)  // Spacer view
        stackView.addArrangedSubview(changeNicknameButton)
        
        bigBox.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bigBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bigBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bigBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bigBox.heightAnchor.constraint(equalToConstant: 220),
            
            stackView.centerXAnchor.constraint(equalTo: bigBox.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: bigBox.centerYAnchor),
            
            changeNicknameButton.widthAnchor.constraint(equalToConstant: 115),
            changeNicknameButton.heightAnchor.constraint(equalToConstant: 35),
            
            spacerView.heightAnchor.constraint(equalToConstant: 10),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 115),
            logoutButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
    }
}
