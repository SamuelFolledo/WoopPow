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
    var moveSet: MoveSet
    
    init(attackSet: AttackSet, moveSet: MoveSet) {
        self.attackSet = attackSet
        self.moveSet = moveSet
    }
}
