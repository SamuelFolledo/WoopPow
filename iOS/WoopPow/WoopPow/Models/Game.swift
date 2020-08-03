//
//  Game.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Game {
    
    var player1: Player
    var player2: Player
    var player1HP: Int = 30
    var player2HP: Int = 30
    
    var gameId: String = ""
    var text: String?
    var winnerUid: String?
    var roundNumber = 0
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
}
