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
    
    //MARK: Views
    var gameView: GameView! {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        return GameView(frame: frame)
    }
    var mainScene: SCNScene!
    var player1ControlView: ControlView!
    var player2ControlView: ControlView!
    
    var samuelAxeKick = SCNAnimationPlayer()
    
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
        self.view = gameView
        mainScene = SCNScene(named: "3DAssets.scnassets/GameScene.scn")! //load Stage1.scn as our mainScene
        let scnView = self.view as! GameView
        // set the scene to the view
        scnView.allowsCameraControl = true
        scnView.antialiasingMode = .multisampling4X
        scnView.scene = mainScene
        scnView.isPlaying = true //start game loop and animation
//        addFloor()
        setupControls()
        setupAnimations()
    }
    
    fileprivate func setupAnimations() {
        guard let samuel = mainScene.rootNode.childNode(withName: "male reference", recursively: true) else {
            print("Failed to find samuel")
            return
        }
//        "AnyConv.com__Male@AxeKick.dae"
//        samuelAxeKick = SCNAnimationPlayer.loadAnimation(fromSceneNamed: "3DAssets.scnassets/Characters/Samuel/Animations/AnyConv.com__Male@AxeKick.dae")
        
//        samuelAxeKick = SCNAnimationPlayer.loadAnimation(fromSceneNamed: "3DAssets.scnassets/Idle.dae")
//        samuel.addAnimationPlayer(samuelAxeKick, forKey: "AxeKick")
        
        
//        guard let animation = myAnimation(path: "3DAssets.scnassets/Idle.dae") else {
//            print("No animation found")
//            return
//        }
        
        guard let animation = myAnimation(path: "Resources/3DAssets.scnassets/Male-AxeKick.dae") else {
            print("No animation found")
            return
        }
        samuel.addAnimation(animation, forKey: "Idle")
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
    
//    fileprivate func addFloor() {
//        let floorGeo = SCNFloor()
//        let floorMaterial = SCNMaterial()
//        floorMaterial.diffuse.contents = UIColor(red: 0.1, green: 0.5, blue: 0.1, alpha: 1.0)
//        floorMaterial.specular.contents = UIColor.black
//        floorGeo.firstMaterial = floorMaterial
//        let floorNode = SCNNode(geometry: floorGeo)
//        mainScene.rootNode.addChildNode(floorNode)
//    }
    
    fileprivate func setupControls() {
        let attackSet = AttackSet(codes: ["1.1", "2.2", "2.3", "2.4", "1.5", "1.6"])
        let moveSet = MoveSet(codes: ["up", "back", "down", "forward"])
        let control = Control(attackSet: attackSet, moveSet: moveSet)
        player1ControlView = ControlView(isLeft: false, control: control)
        view.addSubview(player1ControlView)
        player1ControlView.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        let attackSet2 = AttackSet(codes: ["2.1", "2.2", "1.3", "1.4", "2.5", "2.6"])
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
