//
//  UserKeys.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct UsersKeys {
    
    ///keys for all Collections in the database
    struct Collection {
        static let Users: String = "Users"
        static let UserType: String = "UserType"
    }
    
    ///keys for all User properties
    struct UserInfo {
        static let email: String = "email"
        static let username: String = "username"
        static let userId: String = "userId"
        static let type: String = "type"
    }
    
    ///keys for all UserType
    struct UserType {
        static let Player: String = "Player"
        static let Admin: String = "Admin"
    }
}
