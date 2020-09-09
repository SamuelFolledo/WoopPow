//
//  SignInFormView.swift
//  Bolar iOS
//
//  Created by Uchenna  Aguocha on 7/3/19.
//  Copyright © 2019 Uchenna  Aguocha. All rights reserved.
//

import Foundation
import SnapKit

class SignInFormView: UIView {
    
    // MARK: - UI Components
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = FontManager.setFont()
        label.text = "Email or Username"
        return label
    }()
    
    let emailTextField: UnderlinedTextField = {
        let textField = AppService.emailTextField()
        textField.placeholder = "Enter email or username"
        return textField
    }()
    
    private let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = FontManager.setFont()
        label.text = "Password"
        return label
    }()
    
    let passwordTextField: UnderlinedTextField = {
        let textField = AppService.passwordTextField()
        textField.placeholder = "Enter password"
        return textField
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureAutoLayout() {
         [enterEmailLabel, emailTextField, enterPasswordLabel, passwordTextField].forEach {
            addSubview($0)
        }
        
        enterEmailLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(enterEmailLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        enterPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(enterPasswordLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    func configureTextFieldDelegate(with viewController: UIViewController) {
        [emailTextField, passwordTextField].forEach {
            guard let viewController = viewController as? UITextFieldDelegate else { return }
            $0.delegate = viewController
        }
    }
}

