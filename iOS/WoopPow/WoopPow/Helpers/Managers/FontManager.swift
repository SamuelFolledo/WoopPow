//
//  FontManager.swift
//  WoopPow
//
//  Created by Samuel Folledo on 9/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit.UIFont

struct FontManager {
    
    //MARK: Enum
    enum FontType: String {
        case black = "BurbankBigCondensed-Black"
        case bold = "BurbankBigCondensed-Bold"
        case medium = "BurbankBigCondensed-Medium"
        case light = "BurbankBigCondensed-Light"
    }
    
    //MARK: Methods
    static func setFont(size: CGFloat = 20, fontType: FontType = .bold) -> UIFont {
        let defaultFontSize: CGFloat = 20
        
        switch ATDeviceDetector().screenType {
        case .iPhone4:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize - 5)!
        case .iPhone5:
            return UIFont(name: fontType.rawValue, size: size) ??  UIFont(name: fontType.rawValue, size: defaultFontSize - 3)!
        case .iPhone6AndIphone7:
                return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize - 2)!
        case .iPhone6PAndIPhone7P:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize)!
        case .iPhoneX:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize)!
        case .iPadMini:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize + 2)!
        case .iPadPro10Inch:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize + 4)!
        case .iPadPro:
            return UIFont(name: fontType.rawValue, size: size) ?? UIFont(name: fontType.rawValue, size: defaultFontSize + 6)!
        default:
            return UIFont(name: fontType.rawValue, size: size)!
        }
    }
    
//    enum LabelColor {
//        case blue, yellow
//    }
//    static func applyGradient(label: UILabel, labelColor: LabelColor = .yellow) {
//        let gradientImage: UIImage
//        switch labelColor {
//        case .yellow:
//            gradientImage = UIImage.gradientImageWithBounds(bounds: label.bounds, colors: [UIColor.woopPowYellow.cgColor, UIColor.woopPowYellow.cgColor, UIColor.white.cgColor])
//        case .blue:
//            gradientImage = UIImage.gradientImageWithBounds(bounds: label.bounds, colors: [UIColor.woopPowLightBlue.cgColor, UIColor.white.cgColor])
//        }
//        label.textColor = UIColor(patternImage: gradientImage)
//    }
}
