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

//MARK: Initializers
extension PlayerAttack {
    init?(code: String) {
        switch code {
        case "1.1":
            self = .punch(attack: .punchUpLight)
        case "1.2":
            self = .punch(attack: .punchUpMedium)
        case "1.3":
            self = .punch(attack: .punchUpHard)
        case "1.4":
            self = .punch(attack: .punchDownLight)
        case "1.5":
            self = .punch(attack: .punchDownMedium)
        case "1.6":
            self = .punch(attack: .punchDownHard)
        case "2.1":
            self = .kick(attack: .kickUpLight)
        case "2.2":
            self = .kick(attack: .kickUpMedium)
        case "2.3":
            self = .kick(attack: .kickUpHard)
        case "2.4":
            self = .kick(attack: .kickDownLight)
        case "2.5":
            self = .kick(attack: .kickDownMedium)
        case "2.6":
            self = .kick(attack: .kickDownHard)
        default: return nil
        }
    }
}
