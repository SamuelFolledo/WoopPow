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
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        let moveSetView2 = MoveSetView(size: .zero)
        view.addSubview(moveSetView2)
        moveSetView2.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        
        let moveSetView3 = MoveSetView(size: .zero)
        view.addSubview(moveSetView3)
        moveSetView3.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(200)
        }
    }
    
    //MARK: Helpers
}

//MARK: Extensions
