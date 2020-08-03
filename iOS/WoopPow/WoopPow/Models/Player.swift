//
//  Player.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Player {
    
    var name: String
    var playerId: String
    
    //implement later
    var imageUrl: String?
    var image: UIImage?
    var userType: String?
    var server: String = "0.1.0"
    
    //MARK: Initializers
    init(name: String, playerId: String) {
        self.name = name
        self.playerId = playerId
    }
}
