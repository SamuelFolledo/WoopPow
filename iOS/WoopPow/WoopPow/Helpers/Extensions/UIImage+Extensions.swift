//
//  UIImage+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 9/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    
    /// add a gradient color to texts
    /// - Usage: let gradientImage = UIImage.gradientImageWithBounds(bounds: myLabel.bounds, colors: [firstColor.cgColor, secondColor.cgColor])
    /// - Application: myLabel.textColor = UIColor.init(patternImage: gradientImage)
    /// - Source: https://stackoverflow.com/questions/1266179/how-do-i-add-a-gradient-to-the-text-of-a-uilabel-but-not-the-background
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
