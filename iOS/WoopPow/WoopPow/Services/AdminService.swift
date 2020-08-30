//
//  AdminService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/30/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct AdminService {
    ///register and create a user
    static func createUser(withEmail email: String, password: String, username: String, completion: @escaping (Result<Admin, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let result = result else { return }
            let admin = Admin(userId: result.user.uid, username: username, email: email)
            Admin.setCurrent(admin, writeToUserDefaults: true)
            //update displayName
            guard let user = auth.currentUser else { return }
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
                    completion(.success(admin))
                }
            }
        }
    }
    
    ///save user's info
    static func saveAccountInformation(completion: @escaping (_ error: String?) -> Void) {
        guard let admin = Admin.current,
              let userId = admin.userId
        else { return }
        //Save user info
        let userInfoDocData: [String: Any] = [
            UsersKeys.UserInfo.email: admin.email ?? "",
            UsersKeys.UserInfo.userId: admin.userId ?? "",
            UsersKeys.UserInfo.username: admin.username ?? "",
            UsersKeys.UserInfo.userType: admin.userType.rawValue,
        ]
        let userInfoRef = db.collection(UsersKeys.Collection.Users).document(userId)
        //Save user type
        let userTypeData: [String: Any] = [
            UsersKeys.UserInfo.userType: UsersKeys.UserType.Admin
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
    
    ///fetch admin info and return a admin
    static func fetchAdmin(userId: String, completion: @escaping (Result<Admin, Error>) -> Void) {
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
                let admin = Admin(userId: userId, username: username, email: email)
                completion(.success(admin))
        }
    }
}
