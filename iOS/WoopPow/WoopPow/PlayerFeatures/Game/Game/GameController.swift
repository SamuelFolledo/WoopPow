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
        addFloor()
        addControls()
    }
    
    fileprivate func addFloor() {
        let floorGeo = SCNFloor()
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIColor(red: 0.1, green: 0.5, blue: 0.1, alpha: 1.0)
        floorMaterial.specular.contents = UIColor.black
        floorGeo.firstMaterial = floorMaterial
        let floorNode = SCNNode(geometry: floorGeo)
        mainScene.rootNode.addChildNode(floorNode)
    }
    
    fileprivate func addControls() {
        let attackSet = AttackSet(codes: ["1.1", "2.2", "2.3", "2.4", "1.5", "1.6"])
        let moveSet = MoveSet(codes: ["up", "back", "down", "forward"])
        let control = Control(attackSet: attackSet, moveSet: moveSet)
        let controlView = ControlView(isLeft: true, control: control)
        controlView.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(controlView)
        controlView.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        let attackSet2 = AttackSet(codes: ["2.1", "2.2", "1.3", "1.4", "2.5", "2.6"])
        let moveSet2 = MoveSet(codes: ["up", "back", "down", "forward"])
        let control2 = Control(attackSet: attackSet2, moveSet: moveSet2)
        let controlView2 = ControlView(isLeft: false, control: control2)
        controlView2.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(controlView2)
        controlView2.snp.makeConstraints { (make) in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
    }
}

extension SCNAnimationPlayer {
    class func loadAnimation(fromSceneNamed sceneName: String) -> SCNAnimationPlayer {
        let scene = SCNScene( named: sceneName )!
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
