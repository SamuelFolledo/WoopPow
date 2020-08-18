//
//  Constants.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct Constants {
    struct Views {
        //https://github.com/ninjaprox/NVActivityIndicatorView
        static var indicatorView: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballClipRotateMultiple, color: .label, padding: 0.0)
    }
    
    struct Images {
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
}
