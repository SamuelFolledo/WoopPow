//
//  NavBarView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SnapKit

class NavBarView: UIView {
    
    //MARK: Properties
    var player: Player
    
    //MARK: Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false
        view.backgroundColor = .clear
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.gray.cgColor
        return view
    }()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = Constants.Images.navBarView
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var userImageView: UserImageBackground = {
        let view = UserImageBackground(isLeft: true)
        return view
    }()
    
    //MARK: Init
    required init(player: Player) {
        self.player = player
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    fileprivate func setupView() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        addSubview(userImageView)
        userImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(self.snp.height).multipliedBy(1.3)
            $0.width.equalTo(self.snp.height).multipliedBy(1.3).offset(30)
        }
    }
}
