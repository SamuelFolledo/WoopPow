//
//  UserService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/20/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
//import FirebaseFirestore

struct UserService {
    
    // MARK: - Type Aliases
//    typealias UserTypeCompletion = (UserType?, Error?) -> Void
    
    // MARK: - Static Methods
    
    static func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let user = result?.user else {
                return completion(.failure(NetworkError.custom(errorMessage: "No user found")))
            }
            return completion(.success(user))
        }
    }
    
    ///fetch userType in UserType collection
    static func fetchUserType(userId: String, completion: @escaping (Result<UserType, Error>) -> Void) {
        db.collection(UsersKeys.Collection.UserType)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let userTypeString = data[UsersKeys.UserInfo.userType] as? String,
                    let userType = UserType(rawValue: userTypeString)
                else {
                    return completion(.failure(NetworkError.custom(errorMessage: "No user type")))
                }
                completion(.success(userType))
        }
    }
    
    ///fetch userType in Users collectiion
    static func fetchUserTypeInUsers(userId: String, completion: @escaping (Result<UserType, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let userTypeString = data[UsersKeys.UserInfo.userType] as? String,
                    let userType = UserType(rawValue: userTypeString)
                else {
                    return completion(.failure(NetworkError.custom(errorMessage: "No user type")))
                }
                completion(.success(userType))
        }
    }
    
    static func updateUserEmail(newEmail: String, completion: @escaping (_ error: String?) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: newEmail, completion: { (error) in
            if let error = error {
                completion(error.localizedDescription)
            }
            completion(nil)
        })
    }
    
    ///Fetch User's userId
    static func fetchUserUid(userType: UserType, withEmail email: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .whereField(UsersKeys.UserInfo.userType, isEqualTo: userType.rawValue)
            .whereField(UsersKeys.UserInfo.email, isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot else {
                    return completion(.failure(NetworkError.custom(errorMessage: "No user found with that email")))
                }
                if snapshot.documents.isEmpty {
                    completion(.failure(NetworkError.custom(errorMessage: "No userId found with that email")))
                }
                for document in snapshot.documents {
                    if document.exists {
                        let userId = document.documentID
                        completion(.success(userId))
                    }
                }
        }
    }
    
    static func deleteUser() {
        guard let user = auth.currentUser else { return }
        user.delete { (error) in
            if let error = error {
                print("Error deleting user \(error.localizedDescription)")
            }
            db.collection(UsersKeys.Collection.Users).document(user.uid).delete()
            db.collection(UsersKeys.Collection.UserType).document(user.uid).delete()
            Defaults._removeUser(true)
        }
    }
    
    static func updateUserData(userData: [String: Any], completion: @escaping (_ error: String?) -> Void) {
        guard let userId = auth.currentUser?.uid else { return }
        db.collection(UsersKeys.Collection.Users).document(userId).updateData(userData) { (error) in
            if let error = error {
                return completion(error.localizedDescription)
            }
            switch Defaults.valueOfUserType() {
            case .Player:
                Player.updateCurrent(userDictionary: userData)
            case .Admin:
                print("Updating Admin not completed")
            default:
                break
            }
            completion(nil)
        }
    }
    
    /// signin or register user given 3rd-party credentials (e.g. a Facebook login Access Token, a Google ID Token/Access Token pair, Phone, etc.) and return a bool (true if new user, false exiting user) or error
    /// - Parameters:
    ///   - credential: Any AuthCredential from Google, Facebook, Phone, etc
    ///   - userDictionary: user's data
    ///   - completion: True for new user and False for existing user
    static func authenticateUser(credential: AuthCredential, userDictionary: [String: String], completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { (signInResult, error) in //authenticate user
            if let error = error {
                return completion(.failure(NetworkError.custom(errorMessage: error.localizedDescription)))
            }
            guard let signInResult = signInResult else {
                return completion(.failure(NetworkError.custom(errorMessage: "No user results found")))
            }
            let userId = signInResult.user.uid
            var userDictionary = userDictionary
            userDictionary[UsersKeys.UserInfo.userId] = userId
            //if new user, REGISTER then SAVE to Firestore
            if signInResult.additionalUserInfo!.isNewUser {
                //TODO: Implement Creating Account with Admin
                PlayerService.finishCreatingUser(userDictionary: userDictionary) { (result) in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(_):
                        completion(.success(true))
                    }
                }
            } else { //if not new user LOGIN and UPDATE
                //just like email auth, fetch user's type, then create user, then save it to UserDefaults
                fetchUserType(userId: userId) { (result) in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let userType):
                        switch userType {
                        case .Player:
                            PlayerService.fetchPlayer(userId: userId) { (result) in
                                switch result {
                                case .failure(let error):
                                    completion(.failure(error))
                                case .success(let player):
                                    //save the patient
                                    Defaults.setUserType(userType, writeToUserDefaults: true)
                                    Defaults.hasLoggedInOrCreatedAccount = true
                                    Player.setCurrent(player, writeToUserDefaults: true)
                                    //go to home page
                                    completion(.success(false))
                                }
                            }
                        case .Admin:
                            AdminService.fetchAdmin(userId: userId) { (result) in
                                switch result {
                                case .failure(let error):
                                    completion(.failure(error))
                                case .success(let admin):
                                    //save the patient
                                    Defaults.setUserType(userType, writeToUserDefaults: true)
                                    Defaults.hasLoggedInOrCreatedAccount = true
                                    Admin.setCurrent(admin, writeToUserDefaults: true)
                                    //go to home
                                    completion(.success(false))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
