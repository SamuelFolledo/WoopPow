//
//  MoveType.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Move {
    var defenseMultiplier: CGFloat { get }
    var speedMultiplier: CGFloat { get }
    var cooldown: Int { get }
    var image: UIImage { get }
    var direction: Direction { get }
}

enum MoveType: String, Move {
    
    case up, back, down, forward, none
    
    var defenseMultiplier: CGFloat {
        switch self {
        case .up, .down, .none:
            return 1
        case .back:
            return 0.75
        case .forward:
            return 1.1
        }
    }
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
}
