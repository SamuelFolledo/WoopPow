//
//  Constants.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SceneKit

public let db = Firestore.firestore()
public let auth = Auth.auth()
public let storage = Storage.storage()

struct Constants {
    struct Views {
        //https://github.com/ninjaprox/NVActivityIndicatorView
        static var indicatorView: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballClipRotateMultiple, color: .systemBlue, padding: 0.0)
        
        //https://github.com/ankurbatham/ABAnimateProgressView
        static var indicatorWithImageView: ABAnimateProgressView = ABAnimateProgressView()
    }
    
    struct Images {
        //Game
        static let timeLabelImage = UIImage(named: "timeLabelImage.png")!
        //Views
        static let gameBackground1: UIImage = UIImage(named: "gameControllerBackground1.png")!
        static let homeBackground: UIImage = UIImage(named: "homeBackground.png")!
        static let navBarView: UIImage = UIImage(named: "navBarView.png")!
        static let userImageBackground: UIImage = UIImage(named: "userImageBackground.png")!
        static let currencyContainer: UIImage = UIImage(named: "currencyContainer.png")!
        static let coin: UIImage = UIImage(named: "coin.png")!
        static let diamond: UIImage = UIImage(named: "diamond.png")!
        //Buttons
        static let plus: UIImage = UIImage(named: "plus.png")!
        static let plusButton: UIImage = UIImage(named: "plusButton.png")!
        static let backButton: UIImage = UIImage(named: "backButton.png")!
        static let homeButton: UIImage = UIImage(named: "homeButton.png")!
        static let homeButtonSelected: UIImage = UIImage(named: "homeButtonSelected.png")!
        static let noButton: UIImage = UIImage(named: "noButton.png")!
        static let yesButton: UIImage = UIImage(named: "yesButton.png")!
        static let restartButton: UIImage = UIImage(named: "restartButton.png")!
        static let resumeButton: UIImage = UIImage(named: "resumeButton.png")!
        static let playButton: UIImage = UIImage(named: "playButton.png")!
        //Moves
        static let moveUp: UIImage = UIImage(named: "moveUp.png")!
        static let moveBack: UIImage = UIImage(named: "moveBack.png")!
        static let moveDown: UIImage = UIImage(named: "moveDown.png")!
        static let moveForward: UIImage = UIImage(named: "moveForward.png")!
        //Control
        static let controlBackground: UIImage = UIImage(named: "controlButton.png")!
        static let controlBackgroundRed: UIImage = UIImage(named: "controlButtonRed.png")!
        //Punches
        static let punchUpLight: UIImage = UIImage(named: "punchUpLight.png")!
        static let punchUpMedium: UIImage = UIImage(named: "punchUpMedium.png")!
        static let punchUpHard: UIImage = UIImage(named: "punchUpHard.png")!
        static let punchDownLight: UIImage = UIImage(named: "punchDownLight.png")!
        static let punchDownMedium: UIImage = UIImage(named: "punchDownMedium.png")!
        static let punchDownHard: UIImage = UIImage(named: "punchDownHard.png")!
        //Kicks
        static let kickUpLight: UIImage = UIImage(named: "kickUpLight.png")!
        static let kickUpMedium: UIImage = UIImage(named: "kickUpMedium.png")!
        static let kickUpHard: UIImage = UIImage(named: "kickUpHard.png")!
        static let kickDownLight: UIImage = UIImage(named: "kickDownLight.png")!
        static let kickDownMedium: UIImage = UIImage(named: "kickDownMedium.png")!
        static let kickDownHard: UIImage = UIImage(named: "kickDownHard.png")!
    }
    
    struct Game {
        static let mainScene: SCNScene = SCNScene(named: "3DAssets.scnassets/GameScene.scn")!
    }
    
    static let password: String = "password"
    static let userType: String = "userType"
    static let playerUser: String = "playerUser"
    static let adminUser: String = "adminUser"
}
