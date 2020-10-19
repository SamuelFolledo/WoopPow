//
//  PlayerNode.swift
//  WoopPow
//
//  Created by Mark Kim on 10/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation
import SceneKit

enum PlayerType {
    case samuel, raquel
    
    var playerUrl: String {
        switch self {
        case .samuel:
            return "3DAssets.scnassets/Characters/Samuel/samuel"
        case .raquel:
            return "3DAssets.scnassets/Characters/Raquel/Raquel"
        }
    }
}

enum PlayerAnimationType: String {
    case deathBackLight
    case deathBackMedium
    case deathUpHard
    case dodgeRight
    case dodgeUp
    case hitBodyHard
    case hitBodyMedium
    case hitHeadHard
    case hitHeadMedium
    case idleFight
    case kickFlying
    case kickMMA
    case kickDownHard
    case kickDownMedium
    case kickDownLight
    case kickUpHard
    case kickUpMedium
    case kickUpLight
    case punchDownHard
    case punchDownMedium
    case punchDownLight
    case punchUpHard
    case punchUpMedium
    case punchUpLight
    case dashForward
    case dashBackward
}

class PlayerNode: SCNNode {
    
    private var playerType: PlayerType
    private var isPlayer1: Bool
    
    //MARK: Nodes
    private var daeHolderNode = SCNNode()
    private var characterNode: SCNNode!
    
    //MARK: Animations
    var playerAnimations = [String: CAAnimation]()
    
    init(playerType: PlayerType, isPlayer1: Bool) {
        self.playerType = playerType
        self.isPlayer1 = isPlayer1
        super.init()
        setupModel()
        loadAnimations()
        positionModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func positionModel() {
        switch playerType {
        case .samuel:
            scale = SCNVector3Make(0.0002, 0.0002, 0.0002)
            position = SCNVector3Make(0.5, 0.5, 1.0)
        case .raquel:
            scale = SCNVector3Make(2, 2, 2)
            position = SCNVector3Make(0.5, 0.5, 5.0)
        }
        if isPlayer1 {
            rotation = SCNVector4Make(0, 1, 0, 0) //face right
        } else {
            rotation = SCNVector4Make(0, 1, 0, Float.pi) //face left
        }
    }
    
    private func setupModel() {
        let playerURL = Bundle.main.url(forResource: playerType.playerUrl, withExtension: "dae")
        let playerScene = try! SCNScene(url: playerURL!, options: nil)
        
        for child in playerScene.rootNode.childNodes {
            daeHolderNode.addChildNode(child)
        }
        addChildNode(daeHolderNode)
        switch playerType {
        case .samuel:
            characterNode = daeHolderNode.childNode(withName: "Armature", recursively: true)!
        case .raquel:
            characterNode = daeHolderNode.childNode(withName: "Armature-001", recursively: true)!
        }
    }
    
    private func loadAnimations() {
        var name: String
        switch playerType {
        case .samuel:
            name = "Samuel"
        case .raquel:
            name = "Raquel"
        }
        
        //MARK: Death Animations
        loadAnimation(animationType: .deathBackLight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/death/deathBackLight", withIdentifier: "deathBackLight")
        loadAnimation(animationType: .deathBackMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/death/deathBackMedium", withIdentifier: "deathBackMedium")
        loadAnimation(animationType: .deathUpHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/death/deathUpHard", withIdentifier: "deathUpHard")
        
        //MARK: Dodge Animations
        loadAnimation(animationType: .dodgeRight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/dodge/dodgeRight", withIdentifier: "dodgeRight")
        loadAnimation(animationType: .dodgeUp, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/dodge/dodgeUp", withIdentifier: "dodgeUp")
        
        //MARK: Hit Animations
        loadAnimation(animationType: .hitBodyHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/hit/body/hitBodyHard", withIdentifier: "hitBodyHard")
        loadAnimation(animationType: .hitBodyMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/hit/body/hitBodyMedium", withIdentifier: "hitBodyMedium")
        loadAnimation(animationType: .hitHeadHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/hit/head/hitHeadHard", withIdentifier: "hitHeadHard")
        loadAnimation(animationType: .hitHeadMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/hit/head/hitHeadMedium", withIdentifier: "hitHeadMedium")
        
        //MARK: Idle
        loadAnimation(animationType: .idleFight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/idle/idleFight", withIdentifier: "idleFight")
        
        //MARK: Kick Animations
        loadAnimation(animationType: .kickFlying, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/kickFlying", withIdentifier: "kickFlying")
        loadAnimation(animationType: .kickMMA, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/kickMMA", withIdentifier: "kickMMA")
        loadAnimation(animationType: .kickDownHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/down/kickDownHard", withIdentifier: "kickDownHard")
        loadAnimation(animationType: .kickDownMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/down/kickDownMedium", withIdentifier: "kickDownMedium")
        loadAnimation(animationType: .kickDownLight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/down/kickDownLight", withIdentifier: "kickDownLight")
        loadAnimation(animationType: .kickUpHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/up/kickUpHard", withIdentifier: "kickUpHard")
        loadAnimation(animationType: .kickUpMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/up/kickUpMedium", withIdentifier: "kickUpMedium")
        loadAnimation(animationType: .kickUpLight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/kick/up/kickUpLight", withIdentifier: "kickUpLight")
        
        //MARK: Punch Animations
        loadAnimation(animationType: .punchDownHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/down/punchDownHard", withIdentifier: "punchDownHard")
        loadAnimation(animationType: .punchDownMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/down/punchDownMedium", withIdentifier: "punchDownMedium")
        loadAnimation(animationType: .punchDownLight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/down/punchDownLight", withIdentifier: "punchDownLight")
        loadAnimation(animationType: .punchUpHard, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/up/punchUpHard", withIdentifier: "punchUpHard")
        loadAnimation(animationType: .punchUpMedium, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/up/punchUpMedium", withIdentifier: "punchUpMedium")
        loadAnimation(animationType: .punchUpLight, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/punch/up/punchUpLight", withIdentifier: "punchUpLight")
        
        //MARK: Dash Animations
        loadAnimation(animationType: .dashForward, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/walk/dashForward", withIdentifier: "dashForward")
        loadAnimation(animationType: .dashBackward, inSceneNamed: "3DAssets.scnassets/Characters/\(name)/Animations/walk/dashBackward", withIdentifier: "dashBackward")
    }
    
    private func loadAnimation(animationType: PlayerAnimationType, inSceneNamed scene: String, withIdentifier identifier: String) {
        let scenenURL = Bundle.main.url(forResource: scene, withExtension: "dae")!
        let sceneSource = SCNSceneSource(url: scenenURL, options: nil)!
        let animationObject: CAAnimation = sceneSource.entryWithIdentifier("\(identifier)-1", withClass: CAAnimation.self)!
        animationObject.repeatCount = 0
        animationObject.fadeInDuration = CGFloat(0.2)
        animationObject.fadeOutDuration = CGFloat(0.2)
//        animationObject.usesSceneTimeBase = false
//        animationObject.fillMode = .forwards
        switch animationType {
        case .idleFight:
            animationObject.repeatCount = Float.greatestFiniteMagnitude
        case .deathBackLight, .deathBackMedium, .deathUpHard:
            animationObject.isRemovedOnCompletion = false
        default: break
        }
        playerAnimations[identifier] = animationObject //add animation to dictionary
    }
    
    func playAnimation(type: PlayerAnimationType) {
        characterNode.addAnimation(playerAnimations[type.rawValue]!, forKey: type.rawValue)
    }
}
