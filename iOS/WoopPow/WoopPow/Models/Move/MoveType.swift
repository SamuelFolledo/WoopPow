//
//  MoveType.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

//enum MoveType {
//    case up, down, back, forward
//}

import UIKit

protocol Move {
//    var damage: Int { get }
    var speedMultiplier: CGFloat { get }
    var cooldown: Int { get }
    var image: UIImage { get }
    var direction: Direction { get }
//    var position: AttackSetPosition { get }
}

enum MoveType: Move {
    
    case up, down, back, forward, none
    
    var speedMultiplier: CGFloat {
        switch self {
        case .up, .down, .none:
            return 1
        case .back:
            return 0.5
        case .forward:
            return 2
        }
    }
    var cooldown: Int { return 2 }
    var image: UIImage {
        switch self {
        case .up:
            return Constants.Images.moveUp
        case .down:
            return Constants.Images.moveDown
        case .back:
            return Constants.Images.moveBack
        case .forward:
            return Constants.Images.moveForward
        case .none:
            return UIImage()
        }
    }
    var direction: Direction {
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .back, .forward, .none:
            return .mid
        }
    }
//    var position: AttackSetPosition {
//        switch self {
//        case .up:
//            return 1
//        case .down:
//            return 1
//        case .back:
//            return 0.5
//        case .forward:
//            return 2
//        case .none:
//            return 1
//        }
//    }
}

//MARK: Initializers
extension MoveType {
    init(code: String?) {
        switch code {
        case "1.1":
            self = .up
        case "1.2":
            self = .back
        case "1.3":
            self = .down
        case "1.4":
            self = .forward
        default:
            self = .none
        }
    }
}