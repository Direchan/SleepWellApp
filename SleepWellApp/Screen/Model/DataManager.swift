//
//  DataManager.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/07.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    
    
    func saveUser(user: UserModel) {
        UserDefaults.standard.setValue(user.password, forKey: user.userId)
        UserDefaults.standard.setValue(user.nickname, forKey: "nickname_\(user.userId)")
    }
    
    
    
    func getUser(userId: String) -> UserModel? {
        guard let password = UserDefaults.standard.string(forKey: userId),
              let nickname = UserDefaults.standard.string(forKey: "nickname_\(userId)") else {
            return nil
        }
        return UserModel(userId: userId, password: password, nickname: nickname)
    }
    
    
    
    // 아이디와 비밀번호를 검증하는 메서드
       func validateUser(userId: String, password: String) -> Bool {
           guard let user = getUser(userId: userId) else {
               return false
           }
           return user.password == password
       }
       
    
    
       // 현재 로그인한 사용자를 설정하는 메서드
       func setCurrentUser(userId: String) {
           UserDefaults.standard.setValue(userId, forKey: "currentUser")
       }
       
    
    
       // 현재 로그인한 사용자를 가져오는 메서드
       func getCurrentUser() -> String? {
           return UserDefaults.standard.string(forKey: "currentUser")
       }
       
    
       // 로그인 상태 확인하는 메서드
       func isLoggedIn() -> Bool {
           return getCurrentUser() != nil
       }
}


