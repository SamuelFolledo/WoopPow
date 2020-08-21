//
//  PlayerService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation
import FirebaseAuth

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
            Player.setCurrent(player, writeToUserDefaults: true)
            //update displayName
            guard let user = Auth.auth().currentUser else { return }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { (error) in
                if let error = error {
                    return completion(.failure(error))
                }
                saveAccountInformation { (error) in
                    if let error = error {
                        return completion(.failure(NetworkError.custom(errorMessage: error)))
                    }
                    completion(.success(player))
                }
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
        let userInfoRef = db.collection(UsersKeys.Collection.Users).document(userId)
        //Save user type
        let userTypeData: [String: Any] = [
            UsersKeys.UserInfo.type: UsersKeys.UserType.Player
        ]
        let userTypeRef = db.collection(UsersKeys.Collection.UserType).document(userId)
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
