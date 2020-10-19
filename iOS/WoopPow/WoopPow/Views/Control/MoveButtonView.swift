//
//  MoveButtonView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class MoveButtonView: UIView {
    
    //MARK: Properties
    var move: Move
    var cooldown: Int = 0 {
        didSet {
            if cooldown > 0 { //keep it disabled
                button.isEnabled = false
                button.alpha = 0.6
            } else {
                button.isEnabled = true
                button.alpha = 1
            }
        }
    }
    
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
//        view.backgroundColor = move.backgroundColor
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(move.image, for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.addGlow(withColor: .woopPowLightBlue, size: .medium)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = Constants.Images.controlBackground
        return imageView
    }()
    
    //MARK: Init
    required init(move: Move) {
        self.move = move
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
