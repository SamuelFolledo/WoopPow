//
//  Game.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Turn {
    var attack: Attack = AttackType.None.noneUpLight
    var move: Move = MoveType.none
    var isPlayer1: Bool
    
    init(isPlayer1: Bool) {
        self.isPlayer1 = isPlayer1
    }
    
    init(isPlayer1: Bool, move: Move, attack: Attack) {
        self.isPlayer1 = isPlayer1
        self.move = move
        self.attack = attack
    }
    
    mutating func resetTurn() {
        self.attack = AttackType.None.noneUpLight
        self.move = MoveType.none
    }
}

struct Round {
    var p1Turn: Turn
    var p2Turn: Turn
}

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
