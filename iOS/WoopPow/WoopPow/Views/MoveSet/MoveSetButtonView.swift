//
//  MoveSetButtonView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class MoveSetButtonView: UIView {
    
    //MARK: Properties
    
    //MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    //MARK: Init
    required init(moveImage: UIImage) {
        super.init(frame: .zero)
        self.button.setImage(moveImage, for: .normal)
        setup()
    }
    
    required init(attack: AttackType) {
        super.init(frame: .zero)
        self.button.setImage(attack.image, for: .normal)
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
