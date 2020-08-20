//
//  UserKeys.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct UsersKeys {
    struct CollectionKeys {
        static let users: String = "Users"
        static let userType: String = "UserType"
    }
    
    struct UserInfo {
        static let email: String = "email"
        static let username: String = "username"
        static let userId: String = "userId"
    }
    
    struct UserTypeKeys {
        static let type = "type"
        static let player = "Player"
        static let admin = "Admin"
    }
}
