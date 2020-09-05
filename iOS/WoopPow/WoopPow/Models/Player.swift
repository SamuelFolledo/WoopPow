//
//  Player.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum UserType: String, Codable {
    case Player, Admin
}

struct Player: Codable {
    
    private(set) var username: String?
    private(set) var email: String?
    private(set) var userId: String?
    
    //implement later
    private(set) var userType: UserType = .Player
    var server: String = "0.1.0"
    
    //MARK: Singleton
    private static var _current: Player?
    
    static var current: Player? {
        // Check if current user (tenant) exist
        if let currentUser = _current {
            return currentUser
        } else {
            // Check if the user was saved in UserDefaults. If not, return nil
            guard let user = UserDefaults.standard.getStruct(Player.self, forKey: Constants.playerUser) else { return nil }
            _current = user
            return user
        }
    }
    
    //MARK: Initializers
    init(userId: String, username: String, email: String) {
        self.username = username
        self.userId = userId
        self.email = email
    }
    
    init(userDictionary: [String: Any]) {
        self.username = userDictionary[UsersKeys.UserInfo.username] as? String
        self.userId = userDictionary[UsersKeys.UserInfo.userId] as? String
        self.email = userDictionary[UsersKeys.UserInfo.email] as? String
    }
    
    init() {}
}

// MARK: - Static Methods
extension Player {
    static func setCurrent(_ user: Player, writeToUserDefaults: Bool = false) {
        // Save user's information in UserDefaults excluding passwords and sensitive (private) info
        if writeToUserDefaults {
            UserDefaults.standard.setStruct(user, forKey: Constants.playerUser)
        }
        _current = user
    }
    
    static func removeCurrent(_ removeFromUserDefaults: Bool = false) {
        if removeFromUserDefaults {
            Defaults._removeUser(true)
        }
        _current = nil
    }
}

//MARK: Current Player methods
extension Player {
    static func updateCurrent(userDictionary: [String: Any]) {
        guard var current = Player.current else { return }
        if let username = userDictionary[UsersKeys.UserInfo.username] as? String {
            current.username = username
        }
        if let userId = userDictionary[UsersKeys.UserInfo.userId] as? String {
            current.userId = userId
        }
        if let email = userDictionary[UsersKeys.UserInfo.email] as? String {
            current.email = email
        }
        Player.setCurrent(current, writeToUserDefaults: true)
    }
}
