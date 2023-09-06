//
//  SignUpPageViewController.swift
//  SleepWellApp
//
//  Created by t2023-m0091 on 2023/09/04.
//

import UIKit

class SignUpPageViewController: UIViewController, UITextFieldDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
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
 
        return textField
    }()
    
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
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
    

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let prospectiveText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string

        

        let lengthOfCompletedText = prospectiveText.utf16.count

        if textField == nicknameField {
            return lengthOfCompletedText < 7
        }


    
        if textField == idField {
            return prospectiveText.count <= 12
        }

        if textField == passwordField {
            return prospectiveText.count <= 12
        }

        
        return true
        
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

        nicknameField.delegate = self
        idField.delegate = self
        passwordField.delegate = self

    
        view.backgroundColor = .indigo
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            
            
            //로고이미지 위치
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //가로위치
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -310), //세로위치
            logoImageView.widthAnchor.constraint(equalToConstant: 132),  // 원하는 너비로 설정
            logoImageView.heightAnchor.constraint(equalToConstant: 45),  // 원하는 높이로 설정
            
            
            
            //텍스트필드 위치
            nicknameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
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
            
            

        ])
    }
    



}
