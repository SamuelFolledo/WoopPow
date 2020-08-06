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
        label.text = gameViewModel.player1HpText
        label.numberOfLines = 1
        return label
    }()
    lazy var player2NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = gameViewModel.player2HpText
        label.numberOfLines = 1
        return label
    }()
    lazy var player2HpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.text = "\(gameViewModel.game.initialHp)/\(gameViewModel.game.initialHp)"
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
        let topViewsStackView = UIStackView(axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .top)
        view.addSubview(topViewsStackView)
        topViewsStackView.snp.makeConstraints {
            $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.9)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        let player1StackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .leading)
        let player2StackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .trailing)
        [player1StackView, timeLeftLabel, player2StackView].forEach {
            topViewsStackView.addArrangedSubview($0)
        }
        
        timeLeftLabel.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
            $0.width.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.15)
        }
        //Constraint Player1 topViews
        player1StackView.addArrangedSubview(player1NameLabel)
        player1StackView.addArrangedSubview(player1HpLabel)
        [player1NameLabel, player1HpLabel].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        //Constraint Player2 topViews
        player2StackView.addArrangedSubview(player2NameLabel)
        player2StackView.addArrangedSubview(player2HpLabel)
        [player2NameLabel, player2HpLabel].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
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
