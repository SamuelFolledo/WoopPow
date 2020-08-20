//
//  Player.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum UserType: String {
    case player, admin
}

struct Player {
    
    private(set) var username: String
    private(set) var email: String
    private(set) var userId: String
    
    //implement later
    private(set) var imageUrl: String?
    private(set) var image: UIImage?
    var userType: UserType?
    var server: String = "0.1.0"
    
    //MARK: Initializers
    init(userId: String, username: String, email: String) {
        self.username = username
        self.userId = userId
        self.email = email
        self.userType = .player
    }
}
