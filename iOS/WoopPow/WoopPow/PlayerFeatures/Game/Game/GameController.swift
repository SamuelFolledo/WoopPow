//
//  GameController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/22/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameController: UIViewController {
    
    //MARK: Properties
    var gameViewModel: GameViewModel!
    var gamePlayersView: GamePlayersView!
    var coordinator: AppCoordinator!
    var samuelAnimations = [String: CAAnimation]()
    var idle: Bool = true
    var player1: PlayerNode!
    var player2: PlayerNode!
    
    
    //MARK: Views
    let gameView: GameView = {
        let gameView = GameView(frame: .zero)
        gameView.allowsCameraControl = true
        gameView.antialiasingMode = .multisampling4X
        let mainScene: SCNScene = SCNScene(named: "3DAssets.scnassets/GameScene.scn")!
        gameView.scene = mainScene
        return gameView
    }()
    var player1ControlView: ControlView!
    var player2ControlView: ControlView!
    
    //MARK: Override properties
    override var shouldAutorotate: Bool { return true }
    override var prefersStatusBarHidden: Bool { return true }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    //MARK: App Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        gameViewModel.gameState = .playing
    }
}

extension GameController {
    fileprivate func setupScene() {
        self.coordinator.navigationController.isNavigationBarHidden = true
        setupGameScene()
        setupControls()
        setupAnimations()
        setupGamePlayersView()
        gameViewModel.startRound()
    }
    
    private func setupGamePlayersView() {
        gamePlayersView = GamePlayersView(player1: gameViewModel.game.player1, player2: gameViewModel.game.player2)
        view.addSubview(gamePlayersView)
        gamePlayersView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.height.equalTo(GamePlayersView.viewHeight)
        }
    }
    
    private func setupGameScene() {
        self.view = gameView
        gameView.isPlaying = true //start game loop and animation
    }
    
    fileprivate func setupAnimations() {
        player1 = PlayerNode(playerType: .samuel, isPlayer1: true)
        player1!.scale = SCNVector3Make(0.02, 0.02, 0.02)
        player1!.position = SCNVector3Make(0.0, 0.0, 0.0)
        player1!.rotation = SCNVector4Make(0, 1, 0, Float.pi)
        
        gameView.scene!.rootNode.addChildNode(player1!)
        player1.playAnimation(type: .idleFight)
        
        
//        player1!.setupCollider(with: 0.0026)
//        player1!.setupWeaponCollider(with: 0.0026)
    }
    
    func loadAnimation(withKey: String, sceneName: String, animationIdentifier: String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
        
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            // The animation will only play once
            animationObject.repeatCount = 1
            // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)
//            animationObject.isRemovedOnCompletion = true
            // Store the animation for later use
            samuelAnimations[withKey] = animationObject
        }
    }
    
    func myAnimation(path: String) -> SCNAnimation? {
        let scene = SCNScene(named: path)
        var animation: SCNAnimationPlayer?
        scene?.rootNode.enumerateChildNodes( { (child, stop) in
            if let animationKey = child.animationKeys.first {
                animation = child.animationPlayer(forKey: animationKey)
                // variable pointee: ObjCBool { get nonmutating set }
                stop.pointee = true
            }
        })
        return animation?.animation
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: gameView)
        
        // Let's test if a 3D Object was touch
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        
        let hitResults: [SCNHitTestResult]  = gameView.hitTest(location, options: hitTestOptions)
        //TODO: Scale dae animation when played on a charater
//        if idle {
//            playAnimation(key: "punchUpMedium")
//        } else {
//            stopAnimation(key: "punchUpMedium")
//        }
//        idle = !idle
//        if hitResults.first != nil {
//            if(idle) {
//                playAnimation(key: "kickDownHard")
//            } else {
//                stopAnimation(key: "kickDownHard")
//            }
//            idle = !idle
//            return
//        }
        
        player1.playAnimation(type: .kickDownHard)
    }
    
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        guard let samuelNode = gameView.scene!.rootNode.childNode(withName: "samuel", recursively: true) else {
            print("Failed to find samuel")
            return
        }
        samuelNode.addAnimation(samuelAnimations[key]!, forKey: key)
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
        guard let samuelNode = gameView.scene!.rootNode.childNode(withName: "samuel", recursively: true) else {
            print("Failed to find samuel")
            return
        }
        samuelNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
    
    fileprivate func setupControls() {
        let attackSet = AttackSet(attackCodes: ["punchUpLight", "kickUpMedium", "kickUpHard", "kickDownLight", "punchDownMedium", "punchDownHard"])
        let moveSet = MoveSet(codes: ["up", "back", "down", "forward"])
        let control = Control(attackSet: attackSet, moveSet: moveSet)
        player1ControlView = ControlView(isLeft: true, control: control)
        view.addSubview(player1ControlView)
        player1ControlView.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        let attackSet2 = AttackSet(attackCodes: ["kickUpLight", "punchUpMedium", "punchUpHard", "punchDownLight", "kickDownMedium", "kickDownHard"])
        let moveSet2 = MoveSet(codes: ["up", "back", "down", "forward"])
        let control2 = Control(attackSet: attackSet2, moveSet: moveSet2)
        player2ControlView = ControlView(isLeft: false, control: control2)
        view.addSubview(player2ControlView)
        player2ControlView.snp.makeConstraints { (make) in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
    }
}

extension SCNAnimationPlayer {
    class func loadAnimation(fromSceneNamed sceneName: String) -> SCNAnimationPlayer {
        let scene = SCNScene(named: sceneName)!
        // find top level animation
        var animationPlayer: SCNAnimationPlayer! = nil
        scene.rootNode.enumerateChildNodes { (child, stop) in
            if !child.animationKeys.isEmpty {
                animationPlayer = child.animationPlayer(forKey: child.animationKeys[0])
                stop.pointee = true
            }
        }
        return animationPlayer
    }
}
