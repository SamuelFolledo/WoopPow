//
//  GameViewModel.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

class GameViewModel {
    
    enum GameState {
        case loading, playing, gameOver
    }
    
    //MARK: Properties
    let game: Game
    var gameState: GameState = .loading
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
            delegate.gamePlayersView.player1HpLabel.text = "\(player1Hp)/\(game.initialHp)"
        }
    }
    private(set) var player2Hp: Int = 0 {
        didSet {
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
        startTimeLeftTimer()
    }
    
    private func startTimeLeftTimer() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTurnTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTurnTime() {
        timeLeftCounter -= 1
        if timeLeftCounter == 0 {
            timeLeftTimer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //wait 2 seconds t start time again
                self.timeLeftCounter = self.game.initialTime
                self.startTimeLeftTimer()
            }
        }
    }
}
