//
//  Game.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Game {
    //MARK: Constants
    let initialHp: Int = 100
    let initialTime: Int = 10
    
    //MARK: Properties
    var player1: Player
    var player2: Player
    var player1Hp: Int
    var player2Hp: Int
    
    var gameId: String = ""
    var text: String?
    var winnerUid: String?
    var round = 0
    var gameType: String?
    var isMultiplayer: Bool = false
    var gameHistory = [Int: Round]()
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.player1Hp = initialHp
        self.player2Hp = initialHp
    }
    
    mutating func addRound(roundNumber: Int, round: Round) {
        gameHistory[roundNumber] = round
    }
}
