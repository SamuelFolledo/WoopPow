//
//  GameViewModel.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class GameViewModel {
    
    enum GameState {
        case loading, playing, gameOver
    }
    
    enum RoundResult {
        case p1Won, p2Won, continueRound
    }
    
    //MARK: Properties
    var game: Game
    var gameState: GameState = .loading
    var p1HasSpeedBoost: Bool = true
    weak var delegate: GameController!
    let player1HPProgress = Progress(totalUnitCount: 30)
    let player2HPProgress = Progress(totalUnitCount: 30)
    private var timeLeftTimer: Timer?
    private(set) var timeLeftCounter: Int {
        didSet {
            delegate.gamePlayersView.timeLabel.text = "\(timeLeftCounter)"
        }
    }
    private(set) var player1Hp: Int = 0 {
        didSet {
            game.player1Hp = player1Hp
            delegate.gamePlayersView.player1HpLabel.text = "\(player1Hp)/\(game.initialHp)"
        }
    }
    private(set) var player2Hp: Int = 0 {
        didSet {
            game.player2Hp = player2Hp
            delegate.gamePlayersView.player2HpLabel.text = "\(player2Hp)/\(game.initialHp)"
        }
    }
    
    //MARK: Init
    init(game: Game) {
        self.game = game
        timeLeftCounter = game.initialTime
    }
    
    deinit {
        timeLeftTimer?.invalidate()
    }
    
    //MARK: Methods
    
    func startRound() {
        player1Hp = game.player1Hp
        player2Hp = game.player2Hp
        game.round += 1
        startTimeLeftTimer()
    }
    
    func endRound(completion: @escaping (Result<RoundResult, Error>) -> Void) {
        //create round from both players' turn
        var round: Round
        if game.isMultiplayer { //for multiplayer
            print("multi player not supported yet")
            round = Round(p1Turn: delegate.p1Turn, p2Turn: delegate.p2Turn)
        } else {
            if game.player1.userId == auth.currentUser!.uid { //if user is player1
                round = Round(p1Turn: delegate.p1Turn, p2Turn: delegate.p2Turn)
            } else { //user is player 2
                round = Round(p1Turn: delegate.p1Turn, p2Turn: delegate.p2Turn)
            }
        }
        //get the result
        switch getRoundResultFromControls(round: round) {
        case .p1Won:
            completion(.success(.p1Won))
        case .p2Won:
            completion(.success(.p2Won))
        case .continueRound:
            completion(.success(.continueRound))
        default: return
        }
    }
    
    
    private func startTimeLeftTimer() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTurnTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTurnTime() {
        timeLeftCounter -= 1
        if timeLeftCounter == 0 {
            timeLeftTimer?.invalidate()
            endRound { (result) in
                switch result {
                case .failure(let error):
                    print("ERROR rounded ended \(error.localizedDescription)")
                case .success(let result):
                    switch result {
                    case .p1Won:
                        print("P1 Won")
                        self.gameOver(didPlayer1Won: true)
                    case .p2Won:
                        print("P2 Won")
                        self.gameOver(didPlayer1Won: false)
                    case .continueRound:
                        print("Continuing round")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //wait 1 seconds to start time again
                            self.delegate.p1Turn.resetTurn()
                            self.delegate.p2Turn.resetTurn()
                            self.delegate.player1ControlView.newRound()
                            self.delegate.player2ControlView.newRound()
                            self.game.round += 1
                            self.timeLeftCounter = self.game.initialTime
                            self.startTimeLeftTimer()
                        }
                    }
                }
            }
        }
    }
}

//MARK: Helper Methods
extension GameViewModel {
    
    func getRoundResultFromControls(round: Round) -> RoundResult? {
        if game.isMultiplayer {
            print("Imeplement multiplayer later")
            return .continueRound
        } else {
            let p1Move = round.p1Turn.move
            let p1Attack = round.p1Turn.attack
            let p2Move = round.p2Turn.move
            let p2Attack = round.p2Turn.attack
            let p1Speed = Int(CGFloat(p1Attack.speed) * p1Move.speedMultiplier) + (p1HasSpeedBoost ? 1 : 0)
            let p2Speed = Int(CGFloat(p2Attack.speed) * p2Move.speedMultiplier) + (p1HasSpeedBoost ? 0 : 1)
            if p1Speed > p2Speed { //p1 goes first
                p1HasSpeedBoost = true //set who has +1 speed next round
                let p1Damage = getDamage(playerAttack: p1Attack, enemyMove: p2Move)
                player2Hp -= p1Damage //apply damage
                if player2Hp <= 0 { //p2 died
                    return .p1Won
                }
                let p2Damage = getDamage(playerAttack: p2Attack, enemyMove: p1Move)
                player1Hp -= p2Damage //apply damage
                if player1Hp > 0 { //if p1 died
                    return .continueRound
                } else {
                    return .p2Won
                }
            } else { //p2 goes first
                p1HasSpeedBoost = false
                let p2Damage = getDamage(playerAttack: p2Attack, enemyMove: p1Move)
                player1Hp -= p2Damage
                if player1Hp <= 0 { //p1 died
                    return .p2Won
                }
                let p1Damage = getDamage(playerAttack: p1Attack, enemyMove: p2Move)
                player2Hp -= p1Damage //apply damage
                if player2Hp > 0 { //if p2 died
                    return .continueRound
                } else {
                    return .p1Won
                }
            }
        }
    }
    
    ///returns the player's damage to enemy
    private func getDamage(playerAttack: Attack, enemyMove: Move) -> Int {
        var damage: Int = 0
        if enemyMove.direction == playerAttack.direction || enemyMove.direction == .mid { //attack landed
            damage = Int(CGFloat(playerAttack.damage) * enemyMove.defenseMultiplier)
        } else { //player missed
            print("Player \(playerAttack) missed")
        }
        return damage
    }
}

extension GameViewModel {
    func gameOver(didPlayer1Won: Bool) {
        if didPlayer1Won { //p1 won
            self.delegate.gamePlayersView.player1HpLabel.text = "Winner"
            self.delegate.gamePlayersView.player2HpLabel.text = "Loser"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.delegate.coordinator.navigationController.popViewController(animated: true)
            }
        } else { //p2 won
            self.delegate.gamePlayersView.player2HpLabel.text = "Winner"
            self.delegate.gamePlayersView.player1HpLabel.text = "Loser"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.delegate.coordinator.navigationController.popViewController(animated: true)
            }
        }
    }
}
