//
//  Attack.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Attack {
    var damage: Int { get }
    var speed: Int { get }
    var cooldown: Int { get }
    var image: UIImage { get }
    var direction: Direction { get }
    var position: AttackSetPosition { get }
}
