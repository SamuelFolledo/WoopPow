//
//  UserDefaults+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Keys
    
    private enum Keys {
        static let onboard = "onboard"
        static let cards = "cards"
        static let account = "account"
        static let rewardOnboard = "rewardOnboard"
    }
    
    class var onboard: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.onboard) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.onboard)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var hasLoggedInOrCreatedAccount: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.account) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.account)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var rewardOnboard: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.rewardOnboard) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.rewardOnboard)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var isOnboardingFinished: Bool {
        return onboard
    }
    
    class var isAccountLoggedInOrCreated: Bool {
        return hasLoggedInOrCreatedAccount
    }
    
    class var isRewardOnboardFinished: Bool {
        return rewardOnboard
    }
    
//    class var cards: [Card] {
//        get {
//            guard let data = UserDefaults.standard.value(forKey: Keys.cards) as? Data,
//                  let cards = try? JSONDecoder().decode([Card].self, from: data) else {
//                return []
//            }
//            return cards
//        }
//        set {
//            guard let data = try? JSONEncoder().encode(newValue) else { return }
//            UserDefaults.standard.set(data, forKey: Keys.cards)
//            UserDefaults.standard.synchronize()
//        }
//    }
    
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    
    open func getStruct<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        set(data, forKey: defaultName)
    }
    
    open func getStructArray<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    //delete everything in UserDefaults except for exemptedKeys
    open func deleteAllKeys(exemptedKeys: [String] = []) {
        if exemptedKeys.count == 0 {
            let domain = Bundle.main.bundleIdentifier!
            self.removePersistentDomain(forName: domain)
        } else {
            self.dictionaryRepresentation().keys.forEach { key in
                if !exemptedKeys.contains(key) { //if key is not exempted, delete it
                    self.removeObject(forKey: key)
                }
            }
        }
        self.synchronize()
    }
}
