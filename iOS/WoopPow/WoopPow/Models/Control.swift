//
//  Control.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/16/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct Control {
    
    var attackSet: AttackSet
    var moves: [MoveType]
    
    init(attackSet: AttackSet, moves: [MoveType]) {
        self.attackSet = attackSet
        self.moves = moves
    }
}
