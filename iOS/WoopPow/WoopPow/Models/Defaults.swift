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
            
    static func _removeUser(_ removeFromUserDefaults: Bool = false) {
        
        guard let userType = Defaults.valueOfUserType() else { return }
        
        if removeFromUserDefaults {
            switch userType {
            case .Player:
                UserDefaults.standard.removeObject(forKey: Constants.playerType)
            case .Admin:
                UserDefaults.standard.removeObject(forKey: Constants.adminType)
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
        guard let userTypeString = UserDefaults.standard.value(forKey: Constants.userType) as? String else { return nil }
        guard let userType = UserType(rawValue: userTypeString) else { return nil }
        return userType
    }
}
