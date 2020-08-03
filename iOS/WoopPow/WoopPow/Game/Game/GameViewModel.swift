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
    var timeLeftCounter: Int = 8 {
        didSet { delegate?.timeLeftLabel.text = "\(timeLeftCounter)" }
    }
    
    //MARK: Init
    init(game: Game) {
        self.game = game
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
                self.timeLeftCounter = 8
                self.startTimeLeftTimer()
            }
        }
    }
}
