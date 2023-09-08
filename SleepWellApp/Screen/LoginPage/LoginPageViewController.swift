//
//  LoginPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // 아이디 입력 텍스트 뷰
    private lazy var 아이디텍스트뷰 :UIView = {
        let view  = UIView()
        view.backgroundColor = .deepIndigo
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(아이디입력필드)
        view.addSubview(아이디안내문구)
        return view
    }()
    
    private var 아이디안내문구: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .indigo
        return label
    }()
    
    
    private lazy var 아이디입력필드 : UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .pastelYellow
        tf.tintColor = .pastelYellow
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        //        tf.keyboardType = .emailAddress
        //        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for:
        //                .editingChanged)
        return tf
    }()
    
    private lazy var 비밀번호텍스트뷰 :UIView = {
        let view  = UIView()
        view.backgroundColor = .deepIndigo
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(비밀번호안내문구)
        view.addSubview(비밀번호입력필드)
        view.addSubview(비밀번호표시버튼)
        
        return view
    }()
    
    private var 비밀번호안내문구 : UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .indigo
        return label
    }()
    
    private lazy var 비밀번호입력필드 : UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .pastelYellow
        tf.tintColor = .pastelYellow
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        //        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for:
        //                .editingChanged)
        return tf
    }()
    
    private let 비밀번호표시버튼: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(.indigo, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        //        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    private lazy var 로그인버튼: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .pastelYellow
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .indigo
        button.isEnabled = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var 스택뷰: UIStackView = {
        let st = UIStackView(arrangedSubviews: [아이디텍스트뷰, 비밀번호텍스트뷰, 로그인버튼])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        
        return st
    }()
    
    
    // 회원가입 버튼
    private lazy var 회원가입버튼: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.pastelYellow?.cgColor
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //        button.addTarget(self, action: #selector(resetButtonTapped  ), for: .touchUpInside)
        return button
    }()
    
    
    // 텍스트필드 및로그인 버튼 높이설정
    private let 입력창높이: CGFloat = 48
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(로그인버튼)
        
        ui만들기()
        
    }
    
    func ui만들기() {
        
        view.backgroundColor = .indigo
        view.addSubview(스택뷰)
        view.addSubview(회원가입버튼)
        
        
        아이디안내문구.translatesAutoresizingMaskIntoConstraints = false
        아이디입력필드.translatesAutoresizingMaskIntoConstraints = false
        비밀번호안내문구.translatesAutoresizingMaskIntoConstraints = false
        비밀번호입력필드.translatesAutoresizingMaskIntoConstraints = false
        비밀번호표시버튼.translatesAutoresizingMaskIntoConstraints = false
        스택뷰.translatesAutoresizingMaskIntoConstraints = false
        회원가입버튼.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            아이디안내문구.leadingAnchor.constraint(equalTo: 아이디입력필드.leadingAnchor, constant: 8),
            아이디안내문구.trailingAnchor.constraint(equalTo: 아이디입력필드.trailingAnchor, constant: 8),
            아이디안내문구.centerYAnchor.constraint(equalTo: 아이디입력필드.centerYAnchor, constant: 0),
            
            
            아이디입력필드.leadingAnchor.constraint(equalTo: 아이디텍스트뷰.leadingAnchor, constant: 8),
            아이디입력필드.trailingAnchor.constraint(equalTo: 아이디텍스트뷰.trailingAnchor, constant: 8),
            아이디입력필드.topAnchor.constraint(equalTo: 아이디텍스트뷰.topAnchor, constant: 15),
            아이디입력필드.bottomAnchor.constraint(equalTo: 아이디텍스트뷰.bottomAnchor, constant: 2),
            
            
            비밀번호안내문구.leadingAnchor.constraint(equalTo: 비밀번호텍스트뷰.leadingAnchor, constant: 8),
            비밀번호안내문구.trailingAnchor.constraint(equalTo: 비밀번호텍스트뷰.trailingAnchor, constant: 8),
            비밀번호안내문구.centerYAnchor.constraint(equalTo: 비밀번호텍스트뷰.centerYAnchor),
            
            
            비밀번호입력필드.topAnchor.constraint(equalTo: 비밀번호텍스트뷰.topAnchor, constant: 15),
            비밀번호입력필드.bottomAnchor.constraint(equalTo: 비밀번호텍스트뷰.bottomAnchor, constant: 2),
            비밀번호입력필드.leadingAnchor.constraint(equalTo: 비밀번호텍스트뷰.leadingAnchor, constant: 8),
            비밀번호입력필드.trailingAnchor.constraint(equalTo: 비밀번호텍스트뷰.trailingAnchor, constant: 8),
            
            
            비밀번호표시버튼.topAnchor.constraint(equalTo: 비밀번호텍스트뷰.topAnchor, constant: 15),
            비밀번호표시버튼.bottomAnchor.constraint(equalTo: 비밀번호텍스트뷰.bottomAnchor, constant: -15),
            비밀번호표시버튼.trailingAnchor.constraint(equalTo: 비밀번호텍스트뷰.trailingAnchor, constant: -8),
            
            
            스택뷰.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            스택뷰.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            스택뷰.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            스택뷰.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            스택뷰.heightAnchor.constraint(equalToConstant: 입력창높이*3 + 36),
            
            
            회원가입버튼.topAnchor.constraint(equalTo: 스택뷰.bottomAnchor, constant: 10),
            회원가입버튼.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            회원가입버튼.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            회원가입버튼.heightAnchor.constraint(equalToConstant: 입력창높이)
        ])
    }

    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showEmptyFieldAlert() {
        let alert = UIAlertController(title: "안내", message: "입력되지 않은 항목이 있습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        
        
        if
            아이디입력필드.text?.isEmpty == true ||
            비밀번호입력필드.text?.isEmpty == true {
            // 하나 이상의 필드가 비어있다면 경고 메시지
            showEmptyFieldAlert()
            return
        }
        
        guard let enteredUserId = 아이디입력필드.text, let enteredPassword = 비밀번호입력필드.text else {
            showAlert(message: "ID/비밀번호가 잘못되었습니다.") // 에러 메시지 표시
            return
        }
        
        // 아이디와 비밀번호 검증
        if DataManager.shared.validateUser(userId: enteredUserId, password: enteredPassword) {
            // 로그인 성공, 현재 사용자 설정
            DataManager.shared.setCurrentUser(userId: enteredUserId)
            
            // 로그인 성공 후 동작 (MainTabBarController로 이동 등)
            let tabBarVC = MainTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
        } else {
            showAlert(message: "ID/비밀번호가 잘못되었습니다.")// 로그인 실패, 에러 메시지 표시
        }
    }
    
}

