//
//  AttackSet.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/11/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct AttackSet {
    var upLight: Attack = AttackType.none(attack: .noneUpLight)
    var upMedium: Attack = AttackType.none(attack: .noneUpMedium)
    var upHard: Attack = AttackType.none(attack: .noneUpHard)
    var downLight: Attack = AttackType.none(attack: .noneDownLight)
    var downMedium: Attack = AttackType.none(attack: .noneDownMedium)
    var downHard: Attack = AttackType.none(attack: .noneDownHard)
    
    private var positions: [AttackSetPosition] = []
    
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
                upLight = AttackType.none(attack: .noneUpLight)
            case .upMedium:
                upMedium = AttackType.none(attack: .noneUpMedium)
            case .upHard:
                upHard = AttackType.none(attack: .noneUpHard)
            case .downLight:
                downLight = AttackType.none(attack: .noneDownLight)
            case .downMedium:
                downMedium = AttackType.none(attack: .noneDownMedium)
            case .downHard:
                downHard = AttackType.none(attack: .noneDownHard)
            }
        }
    }
}
