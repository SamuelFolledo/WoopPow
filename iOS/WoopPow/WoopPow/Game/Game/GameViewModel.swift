//
//  GameViewModel.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

class GameViewModel {
    
    //MARK: Properties
    let game: Game
    weak var delegate: GameController?
    let player1HPProgress = Progress(totalUnitCount: 30)
    let player2HPProgress = Progress(totalUnitCount: 30)
    var timeLeftTimer: Timer?
    private(set) var timeLeftCounter: Int {
        didSet { delegate?.timeLeftLabel.text = "\(timeLeftCounter)" }
    }
    private(set) var player1HpText: String
    private(set) var player2HpText: String
    
    //MARK: Init
    init(game: Game) {
        self.game = game
        player1HpText = "\(game.player1Hp)/\(game.initialHp)"
        player2HpText = "\(game.player2Hp)/\(game.initialHp)"
        timeLeftCounter = game.initialTime 
    }
    
    deinit {
        timeLeftTimer?.invalidate()
    }
    
    //MARK: Methods
    
    func startTimeLeftTimer() {
        timeLeftTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTurnTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTurnTime() {
        timeLeftCounter -= 1
        if timeLeftCounter == 0 {
            timeLeftTimer?.invalidate()
            //            setupSelectedTag()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.timeLeftCounter = self.game.initialTime
                self.startTimeLeftTimer()
            }
        }
    }
}
