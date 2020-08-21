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
                    let userTypeString = data[UsersKeys.UserInfo.type] as? String,
                    let userType = UserType(rawValue: userTypeString)
                else {
                    return completion(.failure(NetworkError.custom(errorMessage: "No user type")))
                }
                completion(.success(userType))
        }
    }
    
    ///fetch userType in Users collectiion
    static func fetchUserTypeinUsers(userId: String, completion: @escaping (Result<UserType, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let userTypeString = data[UsersKeys.UserInfo.type] as? String,
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
    
    ///fetch userId of a user given an email
    static func fetchUserId(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .whereField(UsersKeys.UserInfo.email, isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let snapshot = snapshot,
                    let userDoc = snapshot.documents.first
                else {
                    return completion(.failure(NetworkError.custom(errorMessage: "No userId")))
                }
                let userId = userDoc.documentID
                completion(.success(userId))
        }
    }
    
    ///Fetch Player's userId
    static func fetchPlayerUid(withEmail email: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .whereField(UsersKeys.UserInfo.type, isEqualTo: UsersKeys.UserType.Player)
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
}
