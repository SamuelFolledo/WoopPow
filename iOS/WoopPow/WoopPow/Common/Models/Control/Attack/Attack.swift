//
//  Attack.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Attack {
    ///attack's flat damage
    var damage: Int { get }
    ///attack's speed
    var speed: Int { get }
    ///attack's cooldown
    var cooldown: Int { get }
    ///attack's image that will be shown on the button
    var image: UIImage { get }
    ///direction of the attack: up, down, mid
    var direction: Direction { get }
    ///position of the attack on the view: upLight, upMedium, upHard, downLight, downMedium, downHard
    var position: AttackSetPosition { get }
    ///button's backgroundColor
    var backgroundColor: UIColor { get }
}
