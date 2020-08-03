//
//  MainCoordinator.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
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
        let vc = HomeController()
        navigationController.pushViewController(vc, animated: false)
    }
}

//MARK: Private Methods
private extension MainCoordinator {
    func setupNavigationController() {
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.backgroundColor = .systemBackground
        self.navigationController.navigationBar.tintColor = .systemBlue //button color
        //        navigationController.setStatusBarColor(backgroundColor: kMAINCOLOR)
    }
}
