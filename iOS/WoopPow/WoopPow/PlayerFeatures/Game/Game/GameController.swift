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
    
    enum GameState {
        case loading, playing
    }
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var gameState: GameState = .loading
    var samuelAnimations = [String: CAAnimation]()
    var idle: Bool = true
    
    //MARK: Views
    lazy var gameView: GameView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let gameView = GameView(frame: frame)
        gameView.allowsCameraControl = true
        gameView.antialiasingMode = .multisampling4X
        gameView.scene = Constants.Game.mainScene
        return gameView
    }()
    var player1ControlView: ControlView!
    var player2ControlView: ControlView!
    
    //MARK: App Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        gameState = .playing
    }
    
    override var shouldAutorotate: Bool { return true }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}

extension GameController {
    fileprivate func setupScene() {
        self.coordinator.navigationController.isNavigationBarHidden = true
        setupGameScene()
        setupControls()
        setupAnimations()
    }
    
    private func setupGameScene() {
        self.view = gameView
        gameView.isPlaying = true //start game loop and animation
    }
    
    fileprivate func setupAnimations() {
        guard let samuelNode = Constants.Game.mainScene.rootNode.childNode(withName: "samuel", recursively: true) else {
            print("Failed to find samuel")
            return
        }
        print("Samuel's position=", samuelNode.position)
        loadAnimation(withKey: "kickUpFinisher", sceneName: "3DAssets.scnassets/Characters/Samuel/male samuel (1)/Animations/Male/Kick/kickUpFinisher", animationIdentifier: "kickUpFinisher")
        loadAnimation(withKey: "punchUpMedium", sceneName: "3DAssets.scnassets/Characters/Samuel/male samuel (1)/Animations/Male/punch/punchUpMedium", animationIdentifier: "punchUpMedium")
//        let idleScene = SCNScene(named: "3DAssets.scnassets/Characters/Samuel/animation/idleFixed.dae")!
//        loadAnimation(withKey: "kickDownHard", sceneName: "3DAssets.scnassets/Characters/Samuel/animation/kickDownHard", animationIdentifier: "kickDownHard")
//        loadAnimation(withKey: "punchUpHard", sceneName: "3DAssets.scnassets/Characters/Samuel/animation/punchUpHard", animationIdentifier: "punchUpHard")
//        loadAnimation(withKey: "moveForward", sceneName: "3DAssets.scnassets/Characters/Samuel/animation/moveForward", animationIdentifier: "moveForward")
        print(samuelAnimations.count)
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
        if idle {
            playAnimation(key: "punchUpMedium")
        } else {
            stopAnimation(key: "punchUpMedium")
        }
        idle = !idle
//        if hitResults.first != nil {
//            if(idle) {
//                playAnimation(key: "kickDownHard")
//            } else {
//                stopAnimation(key: "kickDownHard")
//            }
//            idle = !idle
//            return
//        }
    }
    
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        guard let samuelNode = Constants.Game.mainScene.rootNode.childNode(withName: "samuel", recursively: true) else {
            print("Failed to find samuel")
            return
        }
        samuelNode.addAnimation(samuelAnimations[key]!, forKey: key)
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
        guard let samuelNode = Constants.Game.mainScene.rootNode.childNode(withName: "samuel", recursively: true) else {
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
