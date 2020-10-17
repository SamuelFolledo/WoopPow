//
//  ControlView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class ControlView: UIView {
    
    //MARK: Properties
    let isLeft: Bool
    let control: Control
    
    //MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        return view
    }()
    
    lazy var movesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Moves"
        label.font = FontManager.setFont()
        label.textAlignment = .center
        return label
    }()
    
    lazy var moveUp: MoveButtonView = {
        let move = self.control.moveSet.up
        let control = MoveButtonView(move: move)
        return control
    }()
    
    lazy var moveBack: MoveButtonView = {
        let move = self.control.moveSet.back
        let control = MoveButtonView(move: move)
        return control
    }()
    
    lazy var moveDown: MoveButtonView = {
        let move = self.control.moveSet.down
        let control = MoveButtonView(move: move)
        return control
    }()
    
    lazy var moveForward: MoveButtonView = {
        let move = self.control.moveSet.forward
        let control = MoveButtonView(move: move)
        return control
    }()
    
    lazy var attacksLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Attacks"
        label.font = FontManager.setFont()
        label.textAlignment = .center
        return label
    }()
    
    lazy var attackUpLight: AttackButtonView = {
        let attack = self.control.attackSet.upLight
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    lazy var attackUpMedium: AttackButtonView = {
        let attack = self.control.attackSet.upMedium
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    lazy var attackUpHard: AttackButtonView = {
        let attack = self.control.attackSet.upHard
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    lazy var attackDownLight: AttackButtonView = {
        let attack = self.control.attackSet.downLight
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    lazy var attackDownMedium: AttackButtonView = {
        let attack = self.control.attackSet.downMedium
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    lazy var attackDownHard: AttackButtonView = {
        let attack = self.control.attackSet.downHard
        let control = AttackButtonView(attack: attack)
        return control
    }()
    
    //MARK: Init
    required init(isLeft: Bool, control: Control) {
        self.isLeft = isLeft
        self.control = control
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    fileprivate func setupView() {
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
        
        movesStackView.addArrangedSubview(moveUp)
        moveUp.snp.makeConstraints {
            $0.width.equalTo(movesStackView.snp.width).multipliedBy(0.3)
            $0.height.equalTo(movesStackView.snp.width).multipliedBy(0.3)
        }
        
        let bottomMovesStackView = UIStackView(axis: .horizontal, spacing: 2, distribution: .equalSpacing, alignment: .center) //contain the back, down, forward moves
        movesStackView.addArrangedSubview(bottomMovesStackView)
        bottomMovesStackView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        let downMoves: [MoveButtonView]
        if isLeft {
            downMoves = [moveBack, moveDown, moveForward]
        } else {
            downMoves = [moveForward, moveDown, moveBack]
            moveUp.flipX()
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
        let upAttacks: [AttackButtonView]
        if isLeft {
            upAttacks = [attackUpLight, attackUpMedium, attackUpHard]
        } else {
            upAttacks = [attackUpHard, attackUpMedium, attackUpLight]
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
        let downAttacks: [AttackButtonView]
        if isLeft {
            downAttacks = [attackDownLight, attackDownMedium, attackDownHard]
        } else {
            downAttacks = [attackDownHard, attackDownMedium, attackDownLight]
        }
        downAttacks.forEach {
            downAttacksStackView.addArrangedSubview($0)
        }
        
        //make all the buttons have the same width and height
        [moveBack, moveDown, moveForward,
        attackUpLight, attackUpMedium, attackUpHard,
        attackDownLight, attackDownMedium, attackDownHard].forEach {
            $0.snp.makeConstraints { (moveButton) in
                moveButton.width.height.equalTo(moveUp)
            }
            if !isLeft {
                $0.flipX()
            }
        }
    }
}
