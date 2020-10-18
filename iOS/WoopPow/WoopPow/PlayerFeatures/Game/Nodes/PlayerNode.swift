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
            return "3DAssets.scnassets/Characters/Raquel/raquel"
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
        playAnimation(type: .idleFight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
//        characterNode = daeHolderNode.childNode(withName: "Armature", recursively: true)!
    }
    
    private func loadAnimations() {
        //MARK: Death Animations
        loadAnimation(animationType: .deathBackLight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/death/deathBackLight", withIdentifier: "deathBackLight")
        loadAnimation(animationType: .deathBackMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/death/deathBackMedium", withIdentifier: "deathBackMedium")
        loadAnimation(animationType: .deathUpHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/death/deathUpHard", withIdentifier: "deathUpHard")
        
        //MARK: Dodge Animations
        loadAnimation(animationType: .dodgeRight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/dodge/dodgeRight", withIdentifier: "dodgeRight")
        loadAnimation(animationType: .dodgeUp, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/dodge/dodgeUp", withIdentifier: "dodgeUp")
        
        //MARK: Hit Animations
        loadAnimation(animationType: .hitBodyHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/hit/body/hitBodyHard", withIdentifier: "hitBodyHard")
        loadAnimation(animationType: .hitBodyMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/hit/body/hitBodyMedium", withIdentifier: "hitBodyMedium")
        loadAnimation(animationType: .hitHeadHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/hit/head/hitHeadHard", withIdentifier: "hitHeadHard")
        loadAnimation(animationType: .hitHeadMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/hit/head/hitHeadMedium", withIdentifier: "hitHeadMedium")
        
        //MARK: Idle
        loadAnimation(animationType: .hitHeadMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/idle/idleFight", withIdentifier: "idleFight")
        
        //MARK: Kick Animations
        loadAnimation(animationType: .kickFlying, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/kickFlying", withIdentifier: "kickFlying")
        loadAnimation(animationType: .kickMMA, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/kickMMA", withIdentifier: "kickMMA")
        loadAnimation(animationType: .kickDownHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/down/kickDownHard", withIdentifier: "kickDownHard")
        loadAnimation(animationType: .kickDownMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/down/kickDownMedium", withIdentifier: "kickDownMedium")
        loadAnimation(animationType: .kickDownLight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/down/kickDownLight", withIdentifier: "kickDownLight")
        loadAnimation(animationType: .kickUpHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/up/kickUpHard", withIdentifier: "kickUpHard")
        loadAnimation(animationType: .kickUpMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/up/kickUpMedium", withIdentifier: "kickUpMedium")
        loadAnimation(animationType: .kickUpLight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/kick/up/kickUpLight", withIdentifier: "kickUpLight")
        
        //MARK: Punch Animations
        loadAnimation(animationType: .punchDownHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/down/punchDownHard", withIdentifier: "punchDownHard")
        loadAnimation(animationType: .punchDownMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/down/punchDownMedium", withIdentifier: "punchDownMedium")
        loadAnimation(animationType: .punchDownLight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/down/punchDownLight", withIdentifier: "punchDownLight")
        loadAnimation(animationType: .punchUpHard, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/up/punchUpHard", withIdentifier: "punchUpHard")
        loadAnimation(animationType: .punchUpMedium, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/up/punchUpMedium", withIdentifier: "punchUpMedium")
        loadAnimation(animationType: .punchUpLight, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/punch/up/punchUpLight", withIdentifier: "punchUpLight")
        
        //MARK: Dash Animations
        loadAnimation(animationType: .dashForward, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/walk/dashForward", withIdentifier: "dashForward")
        loadAnimation(animationType: .dashBackward, inSceneNameed: "3DAssets.scnassets/Characters/Samuel/Animations/walk/dashBackward", withIdentifier: "dashBackward")
    }
    
    private func loadAnimation(animationType: PlayerAnimationType, inSceneNameed scene: String, withIdentifier identifier: String) {
        let scenenURL = Bundle.main.url(forResource: scene, withExtension: "dae")!
        let sceneSource = SCNSceneSource(url: scenenURL, options: nil)!
        
        let animationObject: CAAnimation = sceneSource.entryWithIdentifier("\(identifier)-1", withClass: CAAnimation.self)!
        
        animationObject.repeatCount = 1
        animationObject.fadeInDuration = CGFloat(1)
        animationObject.fadeOutDuration = CGFloat(0.5)
        
        playerAnimations[identifier] = animationObject
    }
    
    func playAnimation(type: PlayerAnimationType) {
//        switch type {
//        case .de:
//            <#code#>
//        default:
//
//        }
        characterNode.addAnimation(playerAnimations[type.rawValue]!, forKey: type.rawValue)
        print(type)
    }
    
}
