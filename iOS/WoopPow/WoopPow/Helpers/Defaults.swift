//
//  Defaults.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation
import FirebaseAuth

struct Defaults {
    private enum Keys {
        static let onboard = "onboard"
        static let cards = "cards"
        static let account = "account"
        static let rewardOnboard = "rewardOnboard"
    }
    
    static var onboard: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.onboard) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.onboard)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var hasLoggedInOrCreatedAccount: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.account) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.account)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var rewardOnboard: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.rewardOnboard) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.rewardOnboard)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: Methods
    static func _removeUser(_ removeFromUserDefaults: Bool = false) {
        guard let userType = Defaults.valueOfUserType() else { return }
        if removeFromUserDefaults {
            switch userType {
            case .Player:
                UserDefaults.standard.removeObject(forKey: Constants.playerUser)
            case .Admin:
                UserDefaults.standard.removeObject(forKey: Constants.adminUser)
            }
            //clear everything in UserDefaults
            UserDefaults.standard.deleteAllKeys(exemptedKeys: ["onboard"])
        }
    }
    
    static func setUserType(_ accountType: UserType, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            UserDefaults.standard.set(accountType.rawValue, forKey: Constants.userType)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func valueOfUserType() -> UserType? {
        guard let userTypeString = UserDefaults.standard.string(forKey: Constants.userType) else { return nil }
        guard let userType = UserType(rawValue: userTypeString) else { return nil }
        return userType
    }
}
