//
//  AttackButtonView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit
import Gifu

class AttackButtonView: UIView, GIFAnimatable {
    
    //MARK: Properties
    var attack: Attack
    var cooldown: Int = 0 {
        didSet {
            if cooldown > 0 { //keep it disabled
                button.isEnabled = false
                button.alpha = 0.4
                imageView.alpha = 0.4
                titleLabel.text = "\(cooldown)"
                titleLabel.isHidden = false
            } else {
                button.isEnabled = true
                button.alpha = 1
                imageView.alpha = 1
                titleLabel.isHidden = true
                titleLabel.text = ""
            }
        }
    }
    public lazy var animator: Animator? = {
        return Animator(withDelegate: self)
    }()

    
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
    
    lazy var fireImageView: GIFImageView = {
        let imageView = GIFImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.prepareForAnimation(withGIFNamed: "strongRedFire")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontManager.setFont(size: 30, fontType: .bold)
        label.numberOfLines = 1
        label.isHidden = true
        return label
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
    
    override public func display(_ layer: CALayer) {
        updateImageIfNeeded()
    }
    
    //MARK: Private Methods
    
    fileprivate func setup() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.addSubview(button)
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        button.addSubview(fireImageView)
        fireImageView.snp.makeConstraints {
            $0.height.width.centerX.centerY.equalToSuperview()
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
