//
//  SignUpPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class SignUpPageViewController: UIViewController, UITextFieldDelegate {
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }    상태바 폰트 색이 검은색이라 시인성을 생각해서 흰색으로 바꾸어야 하나 싶어서 설정해둔 임시 오버라이드, 미구현
    
    let logoImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nicknameField: UITextField = {
        let textField = UITextField()
        configureTextField(for: textField)
        return textField
    }()
    
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nicknameRuleLabel: UILabel = {
        let label = UILabel()
        label.text = "5글자 이내"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var idField: UITextField = {
        let textField = UITextField()
        configureTextField(for: textField)
        return textField
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let idRuleLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자 조합하여 6~12자"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        configureTextField(for: textField)
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        } else {
            textField.textContentType = .password
        }
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .pastelYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordRuleLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자 조합하여 6~12자"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system) // .system 타입은 사용하면 버튼에 대해 기본 터치 애니메이션
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = .pastelYellow
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let prospectiveText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        
        
        let lengthOfCompletedText = prospectiveText.utf16.count
        // 글자수 제한 5자 조건 한글 제대로 반영되지 않는 것 수정해야함
        if textField == nicknameField {
            return lengthOfCompletedText <= 5
        }
        
        
        
        if textField == idField {
            return prospectiveText.count <= 12
        }
        
        if textField == passwordField {
            return prospectiveText.count <= 12
        }
        
        
        return true
        
    }
    
    @objc func signUpButtonTapped() {
        if nicknameField.text?.isEmpty == true ||
            idField.text?.isEmpty == true ||
            passwordField.text?.isEmpty == true {
            // 하나 이상의 필드가 비어있다면 경고 메시지
            showEmptyFieldAlert()
            return
        }
        
        let userId = idField.text ?? ""
        let userPassword = passwordField.text ?? ""
        let nickname = nicknameField.text ?? ""
        
        // 이미 존재하는 아이디인지 확인
        if UserDefaults.standard.string(forKey: userId) != nil {
            showAlert(message: "이미 존재하는 아이디입니다.")
            return
        }
        
        // 아이디와 비밀번호를 UserDefaults에 저장
        UserDefaults.standard.setValue(userPassword, forKey: userId)
        UserDefaults.standard.setValue(nickname, forKey: "nickname_\(userId)")
        
        // 회원가입 완료 메시지
        showAlert(message: "회원가입이 완료되었습니다!")
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showEmptyFieldAlert() {
        let alert = UIAlertController(title: "안내", message: "입력되지 않은 항목이 있습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //공통되는 속성 설정 메소드
    func configureTextField(for textField: UITextField) {
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = .deepIndigo
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nicknameField)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameRuleLabel)
        view.addSubview(idField)
        view.addSubview(idLabel)
        view.addSubview(idRuleLabel)
        view.addSubview(passwordField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordRuleLabel)
        view.addSubview(signUpButton)
        
        nicknameField.delegate = self
        idField.delegate = self
        passwordField.delegate = self
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        
        
        view.backgroundColor = .indigo
        view.addSubview(logoImageView)
        
        
        
        // ---------------------------레이아웃 설정 시작--------------------------------
        
        
        let guide = view.safeAreaLayoutGuide // 상단 영역에서 safeArea설정
        
        
        
        NSLayoutConstraint.activate([
            
            
            //로고이미지 위치
            logoImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //가로위치
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -280), //세로위치
            logoImageView.widthAnchor.constraint(equalToConstant: 132),  // 원하는 너비로 설정
            logoImageView.heightAnchor.constraint(equalToConstant: 45),  // 원하는 높이로 설정
            
            
            
            //텍스트필드 위치
            nicknameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
            nicknameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            idField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idField.topAnchor.constraint(equalTo: nicknameField.bottomAnchor, constant: 50),
            idField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: idField.bottomAnchor, constant: 50),
            passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            
            //텍스트레이블 위치
            nicknameLabel.bottomAnchor.constraint(equalTo: nicknameField.topAnchor, constant: -4),
            nicknameLabel.leftAnchor.constraint(equalTo: nicknameField.leftAnchor),
            nicknameRuleLabel.leftAnchor.constraint(equalTo: nicknameLabel.rightAnchor, constant: 5),
            nicknameRuleLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            
            idLabel.bottomAnchor.constraint(equalTo: idField.topAnchor, constant: -4),
            idLabel.leftAnchor.constraint(equalTo: idField.leftAnchor),
            idRuleLabel.leftAnchor.constraint(equalTo: idLabel.rightAnchor, constant: 5),
            idRuleLabel.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            
            passwordLabel.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -4),
            passwordLabel.leftAnchor.constraint(equalTo: passwordField.leftAnchor),
            passwordRuleLabel.leftAnchor.constraint(equalTo: passwordLabel.rightAnchor, constant: 5),
            passwordRuleLabel.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            signUpButton.heightAnchor.constraint(equalToConstant: 40) // 원하는 높이로 설정합니다.
            
        ])
    }
    
    
    // ---------------------------레이아웃 설정 끝-----------------------------------
}


