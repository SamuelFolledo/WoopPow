//
//  UserImageView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SnapKit

class UserImageBackground: UIView {
    
    //MARK: Properties
    let isLeft: Bool
    
    //MARK: Views
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = Constants.Images.userImageBackground
        return imageView
    }()
    
    lazy var levelView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.addOuterRoundedBorder(borderWidth: 5, borderColor: UIColor.white.withAlphaComponent(0.5))
        return view
    }()
    
    lazy var levelLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Init
    required init(isLeft: Bool) {
        self.isLeft = isLeft
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
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(self.snp.height)
        }
        addSubview(levelView)
        levelView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.width.equalTo(self.snp.height).multipliedBy(0.2)
            $0.top.equalTo(backgroundImageView.snp.height).multipliedBy(0.5)
        }
    }
}
