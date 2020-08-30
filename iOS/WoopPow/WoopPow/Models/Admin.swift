//
//  Admin.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/30/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct Admin: Codable {
    
    private(set) var username: String?
    private(set) var email: String?
    private(set) var userId: String?
    
    //implement later
    private(set) var userType: UserType = .Admin
    var server: String = "0.1.0"
    
    //MARK: Singleton
    private static var _current: Admin?
    
    static var current: Admin? {
        // Check if current user (tenant) exist
        if let currentUser = _current {
            return currentUser
        } else {
            // Check if the user was saved in UserDefaults. If not, return nil
            guard let user = UserDefaults.standard.getStruct(Admin.self, forKey: Constants.adminUser) else { return nil }
            _current = user
            return user
        }
    }
    
    //MARK: Initializers
    init(userId: String, username: String, email: String) {
        self.username = username
        self.userId = userId
        self.email = email
        self.userType = .Admin
    }
    
    init() {}
}

// MARK: - Static Methods
extension Admin {
    static func setCurrent(_ user: Admin, writeToUserDefaults: Bool = false) {
        // Save user's information in UserDefaults excluding passwords and sensitive (private) info
        if writeToUserDefaults {
            UserDefaults.standard.setStruct(user, forKey: Constants.adminUser)
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
