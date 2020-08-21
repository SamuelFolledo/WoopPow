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
    typealias UserTypeCompletion = (UserType?, Error?) -> Void
    
    // MARK: - Static Methods
    
    static func signIn(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                return completion(nil, error)
            }
            guard let user = result?.user else {
                return completion(nil, error)
            }
            return completion(user, nil)
        }
    }
    
    ///fetch userType in UserType collection
    static func fetchUserType(with userId: String, completion: @escaping UserTypeCompletion) {
        db.collection(UsersKeys.Collection.UserType)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(nil, error)
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let userTypeString = data[UsersKeys.UserInfo.type] as? String,
                    let userType = UserType(rawValue: userTypeString)
                    else {
                        return completion(nil, NetworkError.custom(errorMessage: "No user type"))
                }
                completion(userType, nil)
        }
    }
    
    ///fetch userType in Users collectiion
    static func fetchUserTypeinUsers(with userId: String, completion: @escaping UserTypeCompletion) {
        db.collection(UsersKeys.Collection.Users)
            .document(userId)
            .getDocument { (snapshot, error) in
                if let error = error {
                    return completion(nil, error)
                }
                guard let snapshot = snapshot,
                    let data = snapshot.data(),
                    let userTypeString = data[UsersKeys.UserInfo.type] as? String,
                    let userType = UserType(rawValue: userTypeString)
                    else {
                        return completion(nil, NetworkError.custom(errorMessage: "No user type"))
                }
                completion(userType, nil)
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
    
    //fetch userId of a user given an email
    static func fetchUserId(email: String, completion: @escaping (_ userId: String?, _ error: String?) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .whereField(UsersKeys.UserInfo.email, isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(nil, error.localizedDescription)
                    return
                }
                guard let snapshot = snapshot,
                    let userDoc = snapshot.documents.first
                    else { return }
                let userId = userDoc.documentID
                completion(userId, nil)
        }
    }
    
    ///Fetch Tenant's Document ID with their Email
    static func fetchPlayerUid(withEmail email: String, completion: @escaping (String?, Error?) -> Void) {
        db.collection(UsersKeys.Collection.Users)
            .whereField(UsersKeys.UserInfo.type, isEqualTo: UsersKeys.UserType.Player)
            .whereField(UsersKeys.UserInfo.email, isEqualTo: email)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let snapshot = snapshot else { return }
                
                if snapshot.documents.isEmpty {
                    completion(nil, nil)
                }
                
                for document in snapshot.documents {
                    if document.exists {
                        completion(document.documentID, nil)
                    }
                }
                
        }
    }
}
