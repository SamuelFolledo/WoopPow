//
//  PlayerAttack.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum PlayerAttack {
    
    enum Punch {
        case punchUpLight, punchUpMedium, punchUpHard,
        punchDownLight, punchDownMedium, punchDownHard
        
        var damage: Int {
            switch self {
            case .punchUpLight, .punchDownLight:
                return 10
            case .punchUpMedium, .punchDownMedium:
                return 15
            case .punchUpHard, .punchDownHard:
                return 20
            }
        }
    }
    
    enum Kick {
        case kickUpLight, kickUpMedium, kickUpHard,
        kickDownLight, kickDownMedium, kickDownHard
        
        var damage: Int {
            switch self {
            case .kickUpLight, .kickDownLight:
                return 15
            case .kickUpMedium, .kickDownMedium:
                return 20
            case .kickUpHard, .kickDownHard:
                return 25
            }
        }
    }
    
    case kick(attack: Kick)
    case punch(attack: Punch)
}
