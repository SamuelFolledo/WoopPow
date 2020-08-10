//
//  PlayerAttack.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/7/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum PlayerAttack {
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
