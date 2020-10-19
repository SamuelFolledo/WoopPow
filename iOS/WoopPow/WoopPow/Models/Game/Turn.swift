//
//  Turn.swift
//  WoopPow
//
//  Created by Samuel Folledo on 10/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

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
