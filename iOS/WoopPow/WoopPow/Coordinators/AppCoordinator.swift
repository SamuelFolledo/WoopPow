//
//  AppCoordinator.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    //MARK: Properties
    var childCoordinators: [Coordinator] = []
    lazy var navigationController: UINavigationController = UINavigationController()
    
    //MARK: Init
    init(window: UIWindow) {
        window.rootViewController = navigationController
        setupNavigationController()
    }
    
    //MARK: Methods
    func start() {
//        let vc = HomeController()
        let vc = GameController()
        vc.coordinator = self
        let gameViewModel = GameViewModel(game: gameSample())
        vc.gameViewModel = gameViewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToGameController() {
        let gameViewModel = GameViewModel(game: gameSample())
        let vc = GameController()
        vc.gameViewModel = gameViewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func gameSample() -> Game {
        let player1 = Player(name: "Samuel", playerId: "123")
        let player2 = Player(name: "Raquel", playerId: "321")
        let game = Game(player1: player1, player2: player2)
        return game
    }
}

//MARK: Private Methods
private extension AppCoordinator {
    func setupNavigationController() {
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.backgroundColor = .systemBackground
        self.navigationController.navigationBar.tintColor = .systemBlue //button color
        //        navigationController.setStatusBarColor(backgroundColor: kMAINCOLOR)
    }
}