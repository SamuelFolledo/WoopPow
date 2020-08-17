//
//  MoveSet.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct MoveSet {
    var up: Move = MoveType.none
    var back: Move = MoveType.none
    var down: Move = MoveType.none
    var forward: Move = MoveType.none
    
    var positions: [MoveSetPosition] = []
    
    init(codes: [String]) {
        for code in codes {
            let move = MoveType(code: code)
            addMove(move: move)
        }
    }
    
    mutating func addMove(move: Move) {
        if positions.contains(move.position) { //make sure position is not taken yet
            print("Position is already filled")
        } else {
            positions.append(move.position)
            switch move.position {
            case .up:
                self.up = move
            case .back:
                self.back = move
            case .down:
                self.down = move
            case .forward:
                self.forward = move
            default: break
            }
        }
    }
    
    ///turn AttackType to None AttackType
    mutating func removeMove(move: Move) {
        if !positions.contains(move.position) { //make sure position to move exist
            print("No position to remove")
            return
        } else {
            switch move.position {
            case .up:
                up = MoveType.none
            case .back:
                back = MoveType.none
            case .down:
                down = MoveType.none
            case .forward:
                forward = MoveType.none
            default: break
            }
        }
    }
}

