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

public let db = Firestore.firestore()
public let auth = Auth.auth()
public let storage = Storage.storage()

struct Constants {
    struct Views {
        //https://github.com/ninjaprox/NVActivityIndicatorView
        static var indicatorView: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballClipRotateMultiple, color: .label, padding: 0.0)
        
        //https://github.com/ankurbatham/ABAnimateProgressView
        static var indicatorWithImageView: ABAnimateProgressView = ABAnimateProgressView()
    }
    
    struct Images {
        //Buttons
        static let backButton: UIImage = UIImage(named: "backButton")!
        static let homeButton: UIImage = UIImage(named: "homeButton")!
        static let homeButtonSelected: UIImage = UIImage(named: "homeButtonSelected")!
        static let noButton: UIImage = UIImage(named: "noButton")!
        static let yesButton: UIImage = UIImage(named: "yesButton")!
        static let restartButton: UIImage = UIImage(named: "restartButton")!
        static let resumeButton: UIImage = UIImage(named: "resumeButton")!
        //Backgrounds
        static let gameControllerBackground1: UIImage = UIImage(named: "gameControllerBackground1")!
        //Moves
        static let moveUp: UIImage = UIImage(named: "moveUp")!
        static let moveBack: UIImage = UIImage(named: "moveBack")!
        static let moveDown: UIImage = UIImage(named: "moveDown")!
        static let moveForward: UIImage = UIImage(named: "moveForward")!
        //Punches
        static let punchUpLight: UIImage = UIImage(named: "punchUp")!
        static let punchUpMedium: UIImage = UIImage(named: "punchUp")!
        static let punchUpHard: UIImage = UIImage(named: "punchUpHard")!
        static let punchDownLight: UIImage = UIImage(named: "punchDown")!
        static let punchDownMedium: UIImage = UIImage(named: "punchDown")!
        static let punchDownHard: UIImage = UIImage(named: "punchDownHard")!
    }
    
    static let password: String = "password"
    static let userType: String = "userType"
    static let playerUser: String = "playerUser"
    static let adminUser: String = "adminUser"
}
