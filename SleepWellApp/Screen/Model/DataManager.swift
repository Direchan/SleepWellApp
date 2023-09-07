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
}
