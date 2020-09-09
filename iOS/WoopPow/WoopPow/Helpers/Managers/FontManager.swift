//
//  FontManager.swift
//  WoopPow
//
//  Created by Samuel Folledo on 9/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit.UIFont

class FontManager: UIFont {
//    ["BurbankBigCondensed-Black", "BurbankBigCondensed-Light", "BurbankBigCondensed-Bold", "BurbankBigCondensed-Medium"]
    enum FontType: String {
        case black = "BurbankBigCondensed-Black"
        case bold = "HelveticaNeue-UltraLight"
        case medium = "BurbankBigCondensed-Medium"
        case light = "BurbankBigCondensed-Light"
    }
    
    class func setFont(size: CGFloat, fontType: String = FontType.bold.rawValue) -> UIFont {
        let defaultFontSize: CGFloat = 16
        
        switch ATDeviceDetector().screenType {
        case .iPhone4:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize - 5)!
        case .iPhone5:
            return UIFont(name: fontType, size: size) ??  UIFont(name: fontType, size: defaultFontSize - 3)!
        case .iPhone6AndIphone7:
                return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize - 2)!
        case .iPhone6PAndIPhone7P:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize)!
        case .iPhoneX:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize)!
        case .iPadMini:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize + 2)!
        case .iPadPro10Inch:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize + 4)!
        case .iPadPro:
            return UIFont(name: fontType, size: size) ?? UIFont(name: fontType, size: defaultFontSize + 6)!
        default:
            return UIFont(name: fontType, size: size)!
        }
    }
}
