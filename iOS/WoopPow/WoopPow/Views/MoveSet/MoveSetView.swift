//
//  MoveSetView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class MoveSetView: UIView {
    
    //MARK: Properties
    var isLeft: Bool
    
    //MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        view.backgroundColor = .systemBackground
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var movesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Moves"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var upMove: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .green
        return move
    }()
    
    lazy var backMove: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .blue
        return move
    }()
    
    lazy var downMove: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .green
        return move
    }()
    
    lazy var forwardMove: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .red
        return move
    }()
    
    lazy var attacksLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Attacks"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var upLightAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .orange
        return move
    }()
    
    lazy var upMediumAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .orange
        return move
    }()
    
    lazy var upHardAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .orange
        return move
    }()
    
    lazy var downLightAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .systemPink
        return move
    }()
    
    lazy var downMediumAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .systemPink
        return move
    }()
    
    lazy var downHardAttack: MoveSetButtonView = {
        let move = MoveSetButtonView(moveImage: UIImage())
        move.backgroundColor = .systemPink
        return move
    }()
    
    //MARK: Init
    required init(isLeft: Bool) {
        self.isLeft = isLeft
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    fileprivate func setup() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let mainStackView = UIStackView(axis: .vertical, spacing: 12, distribution: .fillEqually, alignment: .center) //contain the movesLabel, movesStackView, attacksLabel and attacksStackView
        containerView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview().offset(-16)
        }
        
        //MOVES
        let movesStackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .center) //contain the upMove and bottomMovesStackView
        mainStackView.addArrangedSubview(movesStackView)
        movesStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        movesStackView.addArrangedSubview(movesLabel)
        movesLabel.snp.makeConstraints { (label) in
            label.height.equalToSuperview().multipliedBy(0.15).priority(.required)
        }
        
        movesStackView.addArrangedSubview(upMove)
        upMove.snp.makeConstraints { (make) in
            make.width.equalTo(movesStackView.snp.width).multipliedBy(0.3)
            make.height.equalTo(movesStackView.snp.width).multipliedBy(0.3)
        }
        
        let bottomMovesStackView = UIStackView(axis: .horizontal, spacing: 2, distribution: .equalSpacing, alignment: .center) //contain the back, down, forward moves
        movesStackView.addArrangedSubview(bottomMovesStackView)
        bottomMovesStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        let downMoves: [MoveSetButtonView]
        if isLeft {
            downMoves = [backMove, downMove, forwardMove]
        } else {
            downMoves = [forwardMove, downMove, backMove]
        }
        downMoves.forEach { bottomMovesStackView.addArrangedSubview($0) }
        
        //ATTACKS
        let attacksStackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .center) //contain the upAttacksStackView and downAttacksStackView
        mainStackView.addArrangedSubview(attacksStackView)
        attacksStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        //attackLabel
        attacksStackView.addArrangedSubview(attacksLabel)
        attacksLabel.snp.makeConstraints { (label) in
            label.height.equalToSuperview().multipliedBy(0.15).priority(.required)
        }
        //upperAttacks
        let upAttacksStackView = UIStackView(axis: .horizontal, spacing: 2, distribution: .equalSpacing, alignment: .center) //contain the upLightAttack, upMediumAttack, upHardAttack
        attacksStackView.addArrangedSubview(upAttacksStackView)
        upAttacksStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        let upAttacks: [MoveSetButtonView]
        if isLeft {
            upAttacks = [upLightAttack, upMediumAttack, upHardAttack]
        } else {
            upAttacks = [upHardAttack, upMediumAttack, upLightAttack]
        }
        upAttacks.forEach {
            upAttacksStackView.addArrangedSubview($0)
        }
        //lowerAttacks
        let downAttacksStackView = UIStackView(axis: .horizontal, spacing: 2, distribution: .equalSpacing, alignment: .center) //contain the downLightAttack, downMediumAttack, downHardAttack
        attacksStackView.addArrangedSubview(downAttacksStackView)
        downAttacksStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        let downAttacks: [MoveSetButtonView]
        if isLeft {
            downAttacks = [downLightAttack, downMediumAttack, downHardAttack]
        } else {
            downAttacks = [downHardAttack, downMediumAttack, downLightAttack]
        }
        downAttacks.forEach {
            downAttacksStackView.addArrangedSubview($0)
        }
        
        //make all the buttons have the same width and height
        [backMove, downMove, forwardMove,
        upLightAttack, upMediumAttack, upHardAttack,
        downLightAttack, downMediumAttack, downHardAttack].forEach {
            $0.snp.makeConstraints { (moveButton) in
                moveButton.width.height.equalTo(upMove)
            }
        }
    }
}
