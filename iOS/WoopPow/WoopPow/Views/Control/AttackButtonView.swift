//
//  AttackButtonView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class AttackButtonView: UIView {
    
    //MARK: Properties
    var attack: Attack
    var cooldown: Int = 0
    
    //MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
//        view.backgroundColor = attack.backgroundColor
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(attack.image, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.addGlow(withColor: .woopPowLightBlue, size: .extraLarge)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = Constants.Images.controlBackground
        return imageView
    }()
    
    //MARK: Init
    
    required init(attack: Attack) {
        self.attack = attack
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    fileprivate func setup() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
