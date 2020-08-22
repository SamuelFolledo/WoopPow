//
//  NavigationBarView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {
    
    var isLeft: Bool
    var player: Player
    let expBarWidth: CGFloat = 5
    lazy var circularPath = UIBezierPath(arcCenter: CGPoint(x: userImageViewBackground.center.x, y: userImageViewBackground.center.y), radius: userImageViewBackground.frame.height / 2 - (expBarWidth / 2), startAngle: 0.23 * CGFloat.pi, endAngle: 1.98 * CGFloat.pi, clockwise: true) //path to draw the experience bar on, 2 pi

    //MARK: Views
    @IBOutlet var contentView: UIView!
    @IBOutlet var navBarImageView: UIImageView!
    @IBOutlet var userView: UIView!
    @IBOutlet var userImageViewBackground: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var levelView: UIView!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    lazy var trackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 2
        trackLayer.lineCap = CAShapeLayerLineCap.round //kCALineCapRound changed to CAShapeLayerLineCap.round
        return trackLayer
    }()
    lazy var experienceBarLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.woopPowYellow.cgColor
        layer.lineWidth = expBarWidth
        layer.lineCap = CAShapeLayerLineCap.square //stroke end
        layer.strokeEnd = 0
        return layer
    }()
    
    //MARK: Initializers
    required init(isLeft: Bool, player: Player) {
        self.isLeft = isLeft
        self.player = player
        super.init(frame: .zero)
        commonInit()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        levelView.layer.cornerRadius = levelView.frame.height / 2
        trackLayer.path = circularPath.cgPath
        experienceBarLayer.path = circularPath.cgPath
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate func setupViews() {
        levelView.layer.cornerRadius = levelView.frame.height / 2
        usernameLabel.text = player.username!
        setupUserExperienceBar()
    }
    
    fileprivate func setupUserExperienceBar() {
//        userImageViewBackground.layer.addSublayer(trackLayer)
        userImageViewBackground.layer.addSublayer(experienceBarLayer)
//        guard let user = User.currentUser() else { print("no user"); return }
        let currentExp: CGFloat = CGFloat(135) //user's current experience
        let maxExp: CGFloat = AppService.getMaxExperienceNeeded(fromLevel: 2)
        let toValue: CGFloat = currentExp / maxExp
        print("Current user experience is \(currentExp)/\(maxExp)")
        //create the animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = toValue
        basicAnimation.duration = 1 //time in seconds animation
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        experienceBarLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
