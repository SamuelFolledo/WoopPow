//
//  Move.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Move {
    ///how much this move will reduce damage received in percentage
    var defenseMultiplier: CGFloat { get }
    ///how much this move will increase speed in percentage
    var speedMultiplier: CGFloat { get }
    ///cooldown of the move
    var cooldown: Int { get }
    ///move's image that will be shown on the button
    var image: UIImage { get }
    ///direction of the attack: up, down, mid
    var direction: Direction { get }
    ///position of the move on the view: up, back, down, forward
    var position: MoveSetPosition { get }
    ///button's backgroundColor
    var backgroundColor: UIColor { get }
}
