//
//  Move.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Move {
    var defenseMultiplier: CGFloat { get }
    var speedMultiplier: CGFloat { get }
    var cooldown: Int { get }
    var image: UIImage { get }
    var direction: Direction { get }
    var position: MoveSetPosition { get }
}
