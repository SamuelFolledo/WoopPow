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
    var p1Attack: AttackType = .none(attack: .noneUpLight)
    var p1Move: MoveType = .none
    var p2Attack: AttackType = .none(attack: .noneUpLight)
    var p2Move: MoveType = .none
    
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
        setupPlayers()
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
    
    fileprivate func setupPlayers() {
        player1 = PlayerNode(playerType: .samuel, isPlayer1: true)
        gameView.scene!.rootNode.addChildNode(player1!)
        player1.playAnimation(type: .idleFight)
        
        player2 = PlayerNode(playerType: .raquel, isPlayer1: false)
        gameView.scene!.rootNode.addChildNode(player2!)
        player2.playAnimation(type: .idleFight)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: gameView)
        
        // Let's test if a 3D Object was touch
        var hitTestOptions = [SCNHitTestOption: Any]()
        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
        
        let hitResults: [SCNHitTestResult]  = gameView.hitTest(location, options: hitTestOptions)
        player1.playAnimation(type: .punchUpLight)
        player2.playAnimation(type: .punchUpHard)
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

