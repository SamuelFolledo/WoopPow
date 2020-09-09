//
//  AppService.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct AppService {
    
    //MARK: Global Service Methods
    
    /// Get maximum experience needed to level up
    /// - Parameter level: player's current level
    /// - Returns: experience needed to level up
    static func getMaxExperienceNeeded(fromLevel level: Int) -> CGFloat {
        var num: Int = 100
        switch level {
        case _ where level > 0:
            num = ((level * (level / 2)) * 100) * (level / 2)
            /*  level 1 = 25
                level 2 = 200
                level 3 = 675
                level 4 = 1600
                level 5 = 3125
                level 10 = 25000
            */
        default: break
        }
        return CGFloat(num)
    }
    
    //MARK: View Services
    
    
    ///returns the app's textfield for names
    static func nameTextField() -> UnderlinedTextField {
        let textField = UnderlinedTextField()
        textField.font = FontManager.setFont(fontType: .bold)
        textField.textColor = .label
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .words
        return textField
    }
    
    ///returns the app's textfield for email
    static func emailTextField() -> UnderlinedTextField {
        let textField = UnderlinedTextField()
        textField.font = FontManager.setFont(fontType: .bold)
        textField.textColor = .label
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .continue
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }
    
    ///returns the app's textfield for password
    static func passwordTextField() -> UnderlinedTextField {
        let textField = UnderlinedTextField()
        textField.font = FontManager.setFont(fontType: .bold)
        textField.textColor = .label
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        //        textField.textContentType = .password
        return textField
    }
    
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
