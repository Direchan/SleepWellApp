//
//  MyPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class MyPageViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - UI 요소 & 각 요소의 속성 설정
    //프로필 정보 배경 박스
    private lazy var bigBox: UIView = {
        let view = UIView()
        view.backgroundColor = .pastelYellow?.withAlphaComponent(0.05)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //닉네임 라벨
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //아이디라벨
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .pastelYellow
        return label
    }()
    
    //닉네임 수정 버튼
    private lazy var changeNicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임변경", for: .normal)
        button.setTitleColor(.pastelYellow, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .deepIndigo
        button.layer.cornerRadius = 17.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(promptForNewNickname), for: .touchUpInside)
        return button
    }()
    
    //빈 공백(스택뷰에서 간격 조정 위해 만들어둔 요소)
    private lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //닉네임+아이디+빈공백+닉네임수정버튼
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //로그아웃 버튼
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
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUserInformation()
    }

    //MARK: - MyPage 함수 모음
    //ui 세팅
    private func setupUI() {
        self.title = "마이페이지"
        view.backgroundColor = .indigo
        setupConstraints()
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    //유저 정보 업데이트하고, UI에도 업데이트
    private func updateUserInformation() {
        guard let currentUserID = DataManager.shared.getCurrentUser(),
              let user = DataManager.shared.getUser(userId: currentUserID) else { return }
        idLabel.text = "@\(user.userId)"
        nicknameLabel.text = user.nickname
    }

    //알럿뷰
    @objc private func promptForNewNickname() {
        let alertController = UIAlertController(title: "별명 변경", message: "새로운 별명을 입력하세요.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "새로운 별명"
            textField.delegate = self
        }
        
        let confirmAction = UIAlertAction(title: "변경", style: .default) { [weak self] _ in
            guard let newNickname = alertController.textFields?.first?.text,
                  !newNickname.isEmpty,
                  let currentUserID = DataManager.shared.getCurrentUser(),
                  var user = DataManager.shared.getUser(userId: currentUserID) else { return }
                  
            user.nickname = newNickname
            DataManager.shared.saveUser(user: user)
            self?.nicknameLabel.text = newNickname
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //텍스트필드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 5
    }
    
    
    //로그아웃
    @objc func logoutButtonTapped() {
        DataManager.shared.logout()
        NotificationCenter.default.post(name: NSNotification.Name("UserDidLogout"), object: nil) //로그아웃 이벤트를 알리기 위해 노티피케이션을 발송 (로그인 페이지로 가기 위한 과정1)
    }
    
    
    
    // MARK: - 오토레이아웃
    private func setupConstraints() {
        view.addSubview(bigBox)
        view.addSubview(logoutButton)
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(spacerView)  // Spacer view
        stackView.addArrangedSubview(changeNicknameButton)
      
        bigBox.addSubview(stackView)
        
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
