//
//  AttackType.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum AttackType: Attack {
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
    var image: UIImage {
        switch self {
        case .kick(let kick):
            return kick.image
        case .punch(let punch):
            return punch.image
        case .none(let none):
            return none.image
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
    var position: AttackSetPosition {
        switch self {
        case .kick(let kick):
            return kick.position
        case .punch(let punch):
            return punch.position
        case .none(let none):
            return none.position
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .kick(let kick):
            return kick.backgroundColor
        case .punch(let punch):
            return punch.backgroundColor
        case .none(let none):
            return none.backgroundColor
        }
    }
}

//MARK: Initializers
extension AttackType {
    init(attackCode: String) {
        switch attackCode {
        case "punchUpLight":
            self = .punch(attack: .punchUpLight)
        case "punchUpMedium":
            self = .punch(attack: .punchUpMedium)
        case "punchUpHard":
            self = .punch(attack: .punchUpHard)
        case "punchDownLight":
            self = .punch(attack: .punchDownLight)
        case "punchDownMedium":
            self = .punch(attack: .punchDownMedium)
        case "punchDownHard":
            self = .punch(attack: .punchDownHard)
        case "kickUpLight":
            self = .kick(attack: .kickUpLight)
        case "kickUpMedium":
            self = .kick(attack: .kickUpMedium)
        case "kickUpHard":
            self = .kick(attack: .kickUpHard)
        case "kickDownLight":
            self = .kick(attack: .kickDownLight)
        case "kickDownMedium":
            self = .kick(attack: .kickDownMedium)
        case "kickDownHard":
            self = .kick(attack: .kickDownHard)
        default:
            fatalError("Unsupported attack")
        }
    }
}

//MARK: Attack Types
extension AttackType {
    enum None: Attack {
        case noneUpLight, noneUpMedium, noneUpHard,
        noneDownLight, noneDownMedium, noneDownHard
        
        var damage: Int { return 0 }
        var speed: Int { return 0 }
        var cooldown: Int { return 0 }
        var image: UIImage { return UIImage() }
        var direction: Direction { return .mid }
        var position: AttackSetPosition {
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
        var backgroundColor: UIColor { return .clear }
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
                return 1
            case .punchUpMedium, .punchDownMedium:
                return 2
            case .punchUpHard, .punchDownHard:
                return 3
            }
        }
        var image: UIImage {
            switch self {
            case .punchUpLight:
                return Constants.Images.punchUpLight
            case .punchUpMedium:
                return Constants.Images.punchUpMedium
            case .punchUpHard:
                return Constants.Images.punchUpHard
            case .punchDownLight:
                return Constants.Images.punchDownLight
            case .punchDownMedium:
                return Constants.Images.punchDownMedium
            case .punchDownHard:
                return Constants.Images.punchDownHard
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
        var position: AttackSetPosition {
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
        var backgroundColor: UIColor {
            switch self {
            case .punchUpLight, .punchUpMedium, .punchUpHard:
                return .orange
            case .punchDownLight, .punchDownMedium, .punchDownHard:
                return .orange
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
                return 2
            case .kickUpMedium, .kickDownMedium:
                return 3
            case .kickUpHard, .kickDownHard:
                return 4
            }
        }
        var image: UIImage {
            switch self {
            case .kickUpLight:
                return Constants.Images.kickUpLight//.withTintColor(.blue)
            case .kickUpMedium:
                return Constants.Images.kickUpMedium//.withTintColor(.blue)
            case .kickUpHard:
                return Constants.Images.kickUpHard//.withTintColor(.blue)
            case .kickDownLight:
                return Constants.Images.kickDownLight//.withTintColor(.green)
            case .kickDownMedium:
                return Constants.Images.kickDownMedium//.withTintColor(.green)
            case .kickDownHard:
                return Constants.Images.kickDownHard//.withTintColor(.green)
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
        var position: AttackSetPosition {
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
        var backgroundColor: UIColor {
            switch self {
            case .kickUpLight, .kickUpMedium, .kickUpHard:
                return .cyan
            case .kickDownLight, .kickDownMedium, .kickDownHard:
                return .cyan
            }
        }
    }
}
