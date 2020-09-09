//
//  DeviceDetector.swift
//  WoopPow
//
//  Created by Samuel Folledo on 9/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ATDeviceDetector {
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6AndIphone7
        case iPhone6PAndIPhone7P
        case iPhoneX
        
        case iPadMini
        case iPadPro
        case iPadPro10Inch
        
        case iPhoneOrIPadSmallSizeUnknown
        case iPadUnknown
        case unknown
    }
    
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH,ScreenSize.SCREEN_HEIGHT)
    }
    
    //MARK: Properties
    var iPhone: Bool { return UIDevice().userInterfaceIdiom == .phone }
    var ipad : Bool { return UIDevice().userInterfaceIdiom == .pad }
    let isRetina = UIScreen.main.scale >= 2.0
    var screenType: ScreenType {
        switch ScreenSize.SCREEN_MAX_LENGTH {
        case 0..<568.0:
            return .iPhone4
        case 568.0:
            return .iPhone5
        case 667.0:
            return .iPhone6AndIphone7
        case 736.0:
            return .iPhone6PAndIPhone7P
        case 812.0:
            return .iPhoneX
        case 568.0..<812.0:
            return .iPhoneOrIPadSmallSizeUnknown
        case 1112.0:
            return .iPadPro10Inch
        case 1024.0:
            return .iPadMini
        case 1366.0:
            return .iPadPro
        case 812.0..<1366.0:
            return .iPadUnknown
        default:
            return .unknown
        }
    }
}
