//
//  PlayerService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case createUser
    case getProperties
    case removeProperty
    case addProperty
    case custom(errorMessage: String)
    
    var description: String {
        switch self {
        case .createUser: return "Failed to save and create a user on Firebase..."
        case .getProperties: return "We weren't able get your properties. Make sure you have strong internet connection."
        case .removeProperty: return "Failed to remove a user's property from Firestore..."
        case .addProperty: return "Failed to add a property..."
        case .custom(let errorMessage): return errorMessage
        }
    }
}

struct PlayerService {
    ///register and create a user
    static func createUser(withEmail email: String, password: String, username: String, completion: @escaping (Result<Player, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let result = result else { return }
            var player = Player(userId: result.user.uid, username: username, email: email)
            player.userType = .Player
            saveAccountInformation { (error) in
                if let error = error {
                    return completion(.failure(NetworkError.custom(errorMessage: error)))
                }
                Player.setCurrent(player, writeToUserDefaults: true)
                completion(.success(player))
            }
        }
    }
    
    ///save user's info
    static func saveAccountInformation(completion: @escaping (_ error: String?) -> Void) {
        guard let player = Player.current,
              let userId = player.userId
        else { return }
        //Save user info
        let userInfoDocData: [String: Any] = [
            UsersKeys.UserInfo.email: player.email ?? "",
            UsersKeys.UserInfo.userId: player.userId ?? "",
            UsersKeys.UserInfo.username: player.username ?? ""
        ]
        let userInfoRef = db.collection(UsersKeys.CollectionKeys.users).document(userId)
        //Save user type
        let userTypeData: [String: Any] = [
            UsersKeys.UserTypeKeys.type: UsersKeys.UserTypeKeys.player
        ]
        let userTypeRef = db.collection(UsersKeys.CollectionKeys.userType).document(userId)
        //Get a new batch
        let batch = db.batch()
        batch.setData(userInfoDocData, forDocument: userInfoRef)
        batch.setData(userTypeData, forDocument: userTypeRef)
        // Commit the batch
        batch.commit { (error) in
            if let error = error {
                return completion(error.localizedDescription)
            }
            completion(nil)
        }
    }
}
