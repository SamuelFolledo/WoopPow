//
//  UIColor+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let woopPowYellow = UIColor(r: 250, g: 227, b: 15, a: 1)
    static let woopPowLightBlue = UIColor(r: 0, g: 255, b: 255, a: 1)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
