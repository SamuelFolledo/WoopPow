//
//  PlayerAttack.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct AttackSet {
    var upLight: Attack = PlayerAttack.none(attack: .noneUpLight)
    var upMedium: Attack = PlayerAttack.none(attack: .noneUpMedium)
    var upHard: Attack = PlayerAttack.none(attack: .noneUpHard)
    var downLight: Attack = PlayerAttack.none(attack: .noneDownLight)
    var downMedium: Attack = PlayerAttack.none(attack: .noneDownMedium)
    var downHard: Attack = PlayerAttack.none(attack: .noneDownHard)
    
    private var positions: [AttackPosition] = []
    
    init(attacks: [Attack]) {
        if attacks.count != 6 {
            print("Not enough attacks")
        }
        for attack in attacks {
            addAttack(attack: attack)
        }
    }
    
    mutating func addAttack(attack: Attack) {
        if positions.contains(attack.position) { //make sure position is not taken yet
            print("Position is already filled")
        } else {
            positions.append(attack.position)
            switch attack.position {
            case .upLight:
                upLight = attack
            case .upMedium:
                upMedium = attack
            case .upHard:
                upHard = attack
            case .downLight:
                downLight = attack
            case .downMedium:
                downMedium = attack
            case .downHard:
                downHard = attack
            }
        }
    }
    
    ///turn AttackType to None AttackType
    mutating func removeAttack(attack: Attack) {
        if !positions.contains(attack.position) { //make sure position to move exist
            print("No position to remove")
            return
        } else {
            switch attack.position {
            case .upLight:
                upLight = PlayerAttack.none(attack: .noneUpLight)
            case .upMedium:
                upMedium = PlayerAttack.none(attack: .noneUpMedium)
            case .upHard:
                upHard = PlayerAttack.none(attack: .noneUpHard)
            case .downLight:
                downLight = PlayerAttack.none(attack: .noneDownLight)
            case .downMedium:
                downMedium = PlayerAttack.none(attack: .noneDownMedium)
            case .downHard:
                downHard = PlayerAttack.none(attack: .noneDownHard)
            }
        }
    }
}

protocol Attack {
    var damage: Int { get }
    var speed: Int { get }
    var cooldown: Int { get }
    var direction: Direction { get }
    var position: AttackPosition { get }
}

enum PlayerAttack: Attack {
    case kick(attack: Kick)
    case punch(attack: Punch)
    case none(attack: None)
    
    var damage: Int {
        switch self {
        case .kick(let kick):
            return kick.damage
        case .punch(let punch):
            return punch.damage
        case .none(let none):
            return none.damage
        }
    }
    var speed: Int {
        switch self {
        case .kick(let kick):
            return kick.speed
        case .punch(let punch):
            return punch.speed
        case .none(let none):
            return none.speed
        }
    }
    var cooldown: Int {
        switch self {
        case .kick(let kick):
            return kick.cooldown
        case .punch(let punch):
            return punch.cooldown
        case .none(let none):
            return none.cooldown
        }
    }
    var direction: Direction {
        switch self {
        case .kick(let kick):
            return kick.direction
        case .punch(let punch):
            return punch.direction
        case .none(let none):
            return none.direction
        }
    }
    var position: AttackPosition {
        switch self {
        case .kick(let kick):
            return kick.position
        case .punch(let punch):
            return punch.position
        case .none(let none):
            return none.position
        }
    }
}

//MARK: Initializers
extension PlayerAttack {
    init(code: String) {
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
        default:
            fatalError("Unsupported attack")
        }
    }
}

//MARK: Move Types
extension PlayerAttack {
    enum None: Attack {
        case noneUpLight, noneUpMedium, noneUpHard,
        noneDownLight, noneDownMedium, noneDownHard
        
        var damage: Int { return 0 }
        var speed: Int { return 0 }
        var cooldown: Int { return 0 }
        var direction: Direction { return .mid }
        var position: AttackPosition {
            switch self {
            case .noneUpLight:
                return .upLight
            case .noneUpMedium:
                return .upMedium
            case .noneUpHard:
                return .upHard
            case .noneDownLight:
                return .downLight
            case .noneDownMedium:
                return .downMedium
            case .noneDownHard:
                return .downHard
            }
        }
    }
        
    enum Punch: Attack {
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
        var speed: Int {
            switch self {
            case .punchUpLight, .punchDownLight:
                return 9
            case .punchUpMedium, .punchDownMedium:
                return 6
            case .punchUpHard, .punchDownHard:
                return 3
            }
        }
        var cooldown: Int {
            switch self {
            case .punchUpLight, .punchDownLight:
                return 2
            case .punchUpMedium, .punchDownMedium:
                return 3
            case .punchUpHard, .punchDownHard:
                return 4
            }
        }
        var direction: Direction {
            switch self {
            case .punchUpLight, .punchUpMedium, .punchUpHard:
                return .up
            case .punchDownLight, .punchDownMedium, .punchDownHard:
                return .down
            }
        }
        var position: AttackPosition {
            switch self {
            case .punchUpLight:
                return .upLight
            case .punchUpMedium:
                return .upMedium
            case .punchUpHard:
                return .upHard
            case .punchDownLight:
                return .downLight
            case .punchDownMedium:
                return .downMedium
            case .punchDownHard:
                return .downHard
            }
        }
    }
    
    enum Kick: Attack {
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
        var speed: Int {
            switch self {
            case .kickUpLight, .kickDownLight:
                return 6
            case .kickUpMedium, .kickDownMedium:
                return 4
            case .kickUpHard, .kickDownHard:
                return 2
            }
        }
        var cooldown: Int {
            switch self {
            case .kickUpLight, .kickDownLight:
                return 3
            case .kickUpMedium, .kickDownMedium:
                return 4
            case .kickUpHard, .kickDownHard:
                return 5
            }
        }
        var direction: Direction {
            switch self {
            case .kickUpLight, .kickUpMedium, .kickUpHard:
                return .up
            case .kickDownLight, .kickDownMedium, .kickDownHard:
                return .down
            }
        }
        var position: AttackPosition {
            switch self {
            case .kickUpLight:
                return .upLight
            case .kickUpMedium:
                return .upMedium
            case .kickUpHard:
                return .upHard
            case .kickDownLight:
                return .downLight
            case .kickDownMedium:
                return .downMedium
            case .kickDownHard:
                return .downHard
            }
        }
    }
}
