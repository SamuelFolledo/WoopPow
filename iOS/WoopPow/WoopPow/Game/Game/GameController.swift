//
//  GameController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    //MARK: Properties
    var gameViewModel: GameViewModel!
    var coordinator: AppCoordinator!
    
    //MARK: Views
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.gameControllerBackground1
        return imageView
    }()
    lazy var timeLeftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .font(size: 32, weight: .bold, design: .default)
        label.text = "\(gameViewModel.timeLeftCounter)"
        label.numberOfLines = 1
        return label
    }()
    lazy var player1NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = "\(gameViewModel.game.player1.name)"
        label.numberOfLines = 1
        return label
    }()
    lazy var player1HpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = "\(gameViewModel.game.player1Hp)/\(gameViewModel.game.initialHp)"
        label.numberOfLines = 1
        return label
    }()
    lazy var player2NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = "\(gameViewModel.game.player2.name)"
        label.numberOfLines = 1
        return label
    }()
    lazy var player2HpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = "\(gameViewModel.game.player2Hp)/\(gameViewModel.game.initialHp)"
        label.numberOfLines = 1
        return label
    }()
    
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        gameViewModel.startTimeLeftTimer()
    }
    
    //MARK: Private Methods
    
    //MARK: Helpers
}

//MARK: Extensions

//MARK: Setup and Constraints Views
private extension GameController {
    func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        setupBackground()
        constraintTopViews()
        constraintMoveSets()
    }
    
    func constraintTopViews() {
        view.addSubview(timeLeftLabel)
        timeLeftLabel.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            $0.width.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.15)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
    
    func constraintMoveSets() {
        let moveSetView = MoveSetView(isLeft: true)
        moveSetView.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(moveSetView)
        moveSetView.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        let moveSetView2 = MoveSetView(isLeft: false)
        moveSetView2.containerView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(moveSetView2)
        moveSetView2.snp.makeConstraints { (make) in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
    }
    
    func setupBackground() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}
