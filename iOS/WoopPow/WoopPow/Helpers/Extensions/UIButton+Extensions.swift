//
//  UIButton+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    
    func asBackButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.backButton, for: .normal)
        return button
    }
    
    func asHomeButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.homeButton, for: .normal)
        button.setImage(Constants.Images.homeButtonSelected, for: .selected)
        return button
    }
    
    func asNoButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.noButton, for: .normal)
        return button
    }
    
    func asYesButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.yesButton, for: .normal)
        return button
    }
    
    func asRestartButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.restartButton, for: .normal)
        return button
    }
    
    func isResumeButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setImage(Constants.Images.resumeButton, for: .normal)
        return button
    }
}
