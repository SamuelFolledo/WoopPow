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
                return 2
            case .punchUpMedium, .punchDownMedium:
                return 3
            case .punchUpHard, .punchDownHard:
                return 4
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
                return 3
            case .kickUpMedium, .kickDownMedium:
                return 4
            case .kickUpHard, .kickDownHard:
                return 5
            }
        }
        var image: UIImage {
            switch self {
            case .kickUpLight:
                return Constants.Images.punchUpLight//.withTintColor(.blue)
            case .kickUpMedium:
                return Constants.Images.punchUpMedium//.withTintColor(.blue)
            case .kickUpHard:
                return Constants.Images.punchUpHard//.withTintColor(.blue)
            case .kickDownLight:
                return Constants.Images.punchDownLight//.withTintColor(.green)
            case .kickDownMedium:
                return Constants.Images.punchDownMedium//.withTintColor(.green)
            case .kickDownHard:
                return Constants.Images.punchDownHard//.withTintColor(.green)
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
