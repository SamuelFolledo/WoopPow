//
//  HomeController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: Properties
    var coordinator: AppCoordinator!
    var player: Player! {
        get { getUser() }
    }
    
    //MARK: Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.homeBackground
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    private lazy var navBarView: NavigationBarView = {
        let navBarView = NavigationBarView(isLeft: true, player: player)
        return navBarView
    }()
    private lazy var playButton: UIButton = {
        let button = AppService.playButton()
        button.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        button.addGlowAnimation(withColor: .systemYellow, withEffect: .large)
        return button
    }()
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Private Methods
    
    func getUser() -> Player? {
        switch Defaults.valueOfUserType() {
        case .Player:
            guard let player = Player.current else { return nil }
            return player
        case .Admin:
            print("Admin userType is not supported yet")
            return nil
        default: return nil
        }
    }
    
    fileprivate func setupViews() {
        setupBackground()
        view.addSubview(navBarView)
        navBarView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(80)
        }
        view.addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.2)
            $0.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    fileprivate func setupBackground() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    //MARK: Helpers
    @objc func goToGame() {
        coordinator.goToGameController()
    }
}

//MARK: Extensions
