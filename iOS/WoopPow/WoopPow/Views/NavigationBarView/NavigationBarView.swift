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
    
    //MARK: Views
    @IBOutlet var contentView: UIView!
    @IBOutlet var navBarImageView: UIImageView!
    @IBOutlet var userView: UIView!
    @IBOutlet var userImageViewBackground: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var levelView: UIView!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
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
    }
}
