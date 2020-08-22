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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var navBarImageView: UIImageView!
    @IBOutlet var userView: UIView!
    @IBOutlet var userImageViewBackground: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var levelView: UIView!
    @IBOutlet var levelLabel: UILabel!
    
    
    required init(isLeft: Bool) {
        self.isLeft = isLeft
        super.init(frame: .zero)
        commonInit()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate func setupViews() {
        levelView.layer.cornerRadius = levelView.frame.height / 2
    }
}
