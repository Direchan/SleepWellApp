//
//  MyPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class MyPageViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var bigBox: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.05)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
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
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        
        if let currentUserID = DataManager.shared.getCurrentUser(),
           let user = DataManager.shared.getUser(userId: currentUserID) {
            idLabel.text = "@\(user.userId)"
            nicknameLabel.text = user.nickname
        }
        
    }
    
    @objc private func changeNicknameButtonTapped() {
        promptForNewNickname()
    }
    
    
    
    
    private func promptForNewNickname() {
        let alertController = UIAlertController(title: "별명 변경", message: "새로운 별명을 입력하세요.", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "새로운 별명"
            textField.delegate = self
        }
        
        let confirmAction = UIAlertAction(title: "변경", style: .default) { [weak self] (_) in
            if let newNickname = alertController.textFields?.first?.text, !newNickname.isEmpty {
                // 새로운 별명을 저장합니다.
                if let currentUserID = DataManager.shared.getCurrentUser() {
                    var user = DataManager.shared.getUser(userId: currentUserID)!
                    user.nickname = newNickname
                    DataManager.shared.saveUser(user: user)
                    
                    // 변경된 별명을 화면에 표시합니다.
                    self?.nicknameLabel.text = newNickname
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 5
    }
    
    @objc func logoutButtonTapped() {
        DataManager.shared.logout()
        NotificationCenter.default.post(name: NSNotification.Name("UserDidLogout"), object: nil)
        
    }
    
    
    
    
    private func setupUI() {
        view.addSubview(bigBox)
        view.addSubview(logoutButton)
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(spacerView)  // Spacer view
        stackView.addArrangedSubview(changeNicknameButton)
        changeNicknameButton.addTarget(self, action: #selector(changeNicknameButtonTapped), for: .touchUpInside)
        
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
