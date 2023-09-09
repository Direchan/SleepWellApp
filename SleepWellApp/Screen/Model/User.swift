//
//  User.swift
//  SleepWellApp
//
//  Created by FUTURE on 2023/09/07.
//

import UIKit

struct UserModel: Codable {
    var userId: String
    var password: String
    var nickname: String
    
    init(userId: String, password: String, nickname: String) {
        self.userId = userId
        self.password = password
        self.nickname = nickname
    }
}

