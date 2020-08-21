//
//  AppService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct AppService {
    static func playButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.playButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func backButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.backButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func homeButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.homeButton, for: .normal)
        button.setImage(Constants.Images.homeButtonSelected, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func noButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.noButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func yesButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.yesButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func restartButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.restartButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
    
    static func resumeButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.resumeButton, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        return button
    }
}
