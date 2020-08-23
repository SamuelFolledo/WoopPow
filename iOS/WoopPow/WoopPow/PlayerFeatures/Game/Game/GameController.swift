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
    var coordinator: AppCoordinator!
    
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
        // create a new scene
//        let scene = SCNScene(named: "3DAssets.scnassets/GameScene.scn")!
//
//        // create and add a camera to the scene
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        cameraNode.position = SCNVector3(x: 0, y: 1050, z: 120)
//        scene.rootNode.addChildNode(cameraNode)
//        // place the camera
//
//        // create and add a light to the scene
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = .directional //directional, omni
//        lightNode.position = SCNVector3(x: 0, y: 20, z: 20)
//        scene.rootNode.addChildNode(lightNode)
//
//        // create and add an ambient light to the scene
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = .ambient
//        ambientLightNode.light!.color = UIColor.darkGray
//        scene.rootNode.addChildNode(ambientLightNode)
//
//        // retrieve the ship node
////        let ship = scene.rootNode.childNode(withName: "mixamorig_Hips", recursively: true)!
//
//        // animate the 3d object
////        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
//
//        // retrieve the SCNView
////        sceneView = self.view as! SCNView
//
//        self.view = sceneView
//        let scnView = self.view as! SCNView
//        // set the scene to the view
//        scnView.scene = scene
//
//        // allows the user to manipulate the camera
//        scnView.allowsCameraControl = true
//
//        // show statistics such as fps and timing information
//        scnView.showsStatistics = true
//
//        // configure the view
//        scnView.backgroundColor = UIColor.black
//
//        // add a tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        scnView.addGestureRecognizer(tapGesture)
//
//        //MARK: Floor
//
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
