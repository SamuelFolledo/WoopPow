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
    
    //MARK: Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.homeBackground
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = AppService.playButton()
        button.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        return button
    }()
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Private Methods
    fileprivate func setupViews() {
        setupBackground()
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
