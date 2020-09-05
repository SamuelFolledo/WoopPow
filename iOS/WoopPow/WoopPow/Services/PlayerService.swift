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
    case noUserFound
    case noUserTypeFound
    case custom(errorMessage: String)
    
    var description: String {
        switch self {
        case .createUser: return "Failed to save and create a user on Firebase..."
        case .noUserFound: return "Failed to find a user"
        case .noUserTypeFound: return "Failed to find user's user type"
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
            let userDictionary: [String: String] = [
                UsersKeys.UserInfo.userId: result.user.uid,
                UsersKeys.UserInfo.username: username,
                UsersKeys.UserInfo.email: email,
            ]
            finishCreatingUser(userDictionary: userDictionary) { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let player):
                    completion(.success(player))
                }
            }
        }
    }
    
    ///update user's name and photoUrl if available and returns patient or error
    static func finishCreatingUser(userDictionary: [String: String], completion: @escaping (Result<Player, Error>) -> Void) {
        let player = Player(userDictionary: userDictionary)
        //update user's displayName and photoUrl
        guard let user = auth.currentUser else { return }
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = player.username
        if let userPhotoUrl = userDictionary[UsersKeys.UserInfo.photoUrl] { //update user's photoUrl if available
            changeRequest.photoURL = URL(string: userPhotoUrl)
        }
        changeRequest.commitChanges { (error) in
            if let error = error {
                return completion(.failure(error))
            }
            saveAccountInformation(userDictionary: userDictionary) { (error) in
                if let error = error {
                    return completion(.failure(NetworkError.custom(errorMessage: error)))
                }
                Player.setCurrent(player, writeToUserDefaults: true)
                Defaults.hasLoggedInOrCreatedAccount = true
                Defaults.setUserType(.Player, writeToUserDefaults: true)
                completion(.success(player))
            }
        }
    }
    
    ///save user's newly created account info
    static func saveAccountInformation(userDictionary: [String: String], completion: @escaping (_ error: String?) -> Void) {
        var userDictionary = userDictionary
        userDictionary.removeValue(forKey: UsersKeys.UserInfo.photoUrl) //remove photoUrl
        guard let userId = userDictionary[UsersKeys.UserInfo.userId] else { return }
        //Save user info
        let userRef = db.collection(UsersKeys.Collection.Users).document(userId)
        //Save user type
        let userTypeData: [String: Any] = [
            UsersKeys.UserInfo.userType: UsersKeys.UserType.Player
        ]
        let userTypeRef = db.collection(UsersKeys.Collection.UserType).document(userId)
        //Get a new batch
        let batch = db.batch()
        batch.setData(userDictionary, forDocument: userRef)
        batch.setData(userTypeData, forDocument: userTypeRef)
        // Commit the batch
        batch.commit { (error) in
            if let error = error {
                return completion(error.localizedDescription)
            }
            completion(nil)
        }
    }
    
    ///fetch player info and return a player
    static func fetchPlayer(userId: String, completion: @escaping (Result<Player, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let username = data[UsersKeys.UserInfo.username] as? String,
                    let email = data[UsersKeys.UserInfo.email] as? String
                else { return completion(.failure(NetworkError.custom(errorMessage: "User not found"))) }
                let player = Player(userId: userId, username: username, email: email)
                completion(.success(player))
        }
    }
}
