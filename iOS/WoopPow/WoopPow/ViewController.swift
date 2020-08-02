//
//  ViewController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    //MARK: Views
    
    //MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Private Methods
    fileprivate func setupViews() {
        view.backgroundColor = .systemBackground
        let moveSetView = MoveSetView(size: .zero)
        view.addSubview(moveSetView)
        moveSetView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        moveSetView.backgroundColor = .systemGroupedBackground
    }
    
    //MARK: Helpers
}

//MARK: Extensions
