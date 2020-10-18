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
    
    func addMoveSets(p1Move: Move?, p1Attack: Attack?, p2Move: Move?, p2Attack: Attack?) {
        if game.isMultiplayer {
            print("Imeplement multiplayer later")
        } else {
            guard let p1Move = p1Move, let p1Attack = p1Attack, let p2Move = p2Move, let p2Attack = p2Attack else { return }
            let p1Speed = Int(CGFloat(p1Attack.speed) * p1Move.speedMultiplier) + (p1HasSpeedBoost ? 1 : 0)
            let p2Speed = Int(CGFloat(p2Attack.speed) * p2Move.speedMultiplier) + (p1HasSpeedBoost ? 0 : 1)
            if p1Speed > p2Speed { //p1 goes first
                p1HasSpeedBoost = true
                let p1Damage = getDamage(playerAttack: p1Attack, enemyMove: p2Move)
                player2Hp -= p1Damage //apply damage
                if player2Hp > 0 { //p2 is still alive
                    let p2Damage = getDamage(playerAttack: p2Attack, enemyMove: p1Move)
                    player1Hp -= p2Damage //apply damage
                } else {
                    print("Player 1 won!")
                }
            } else { //p2 goes first
                p1HasSpeedBoost = false
                let p2Damage = getDamage(playerAttack: p2Attack, enemyMove: p1Move)
                player1Hp -= p2Damage
                if player1Hp > 0 { //p1 is still alive
                    let p1Damage = getDamage(playerAttack: p1Attack, enemyMove: p2Move)
                    player2Hp -= p1Damage
                } else {
                    print("Player 2 won!")
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
    
    private func startTimeLeftTimer() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTurnTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTurnTime() {
        timeLeftCounter -= 1
        if timeLeftCounter == 0 {
            timeLeftTimer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //wait 2 seconds t start time again
                self.game.round += 1
                self.timeLeftCounter = self.game.initialTime
                self.startTimeLeftTimer()
            }
        }
    }
}
