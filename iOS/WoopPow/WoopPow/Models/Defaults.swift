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
        
        guard let userTypeString = Defaults.valueOfUserType(),
              let accountType = UserType(rawValue: userTypeString)
        else { return }
        
        if removeFromUserDefaults {
            switch accountType {
            case .player:
                UserDefaults.standard.removeObject(forKey: Constants.playerType)
            case .admin:
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
    
    static func valueOfUserType() -> String? {
        guard let value = UserDefaults.standard.value(forKey: Constants.userType) else { return nil }
        return value as? String
    }
}
