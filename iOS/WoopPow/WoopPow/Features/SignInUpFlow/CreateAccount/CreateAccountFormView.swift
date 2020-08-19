//
//  CreateAccountFormView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit

class CreateAccountFormView: UIView {
        
    // MARK: - UI Components
    
     private let enterUsernameLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.textAlignment = .left
         label.font = .font(size: 16, weight: .bold, design: .default)
         label.text = "Username"
         label.numberOfLines = 1
         return label
     }()
    
    let usernameTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "Enter your username"
        textField.font = .font(size: 18, weight: .medium, design: .rounded)
        textField.textColor = .black
//        textField.backgroundColor = UIColor(r: 242, g: 242, b: 242, a: 1)
//        textField.setPadding(left: 15, right: 15)
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .continue
        textField.autocapitalizationType = .words
        return textField
    }()
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .font(size: 16, weight: .bold, design: .default)
        label.text = "Email"
        label.numberOfLines = 1
        return label
    }()
    
    let emailTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "Enter email"
        textField.font = .font(size: 18, weight: .medium, design: .rounded)
        textField.textColor = .black
//        textField.backgroundColor = UIColor(r: 242, g: 242, b: 242, a: 1)
//        textField.setPadding(left: 15, right: 15)
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .continue
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .font(size: 16, weight: .bold, design: .default)
        label.text = "Password"
        label.numberOfLines = 1
        return label
    }()

    let passwordTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "Enter password"
//        textField.backgroundColor = UIColor(r: 242, g: 242, b: 242, a: 1)
//        textField.setPadding(left: 15, right: 15)
        textField.layer.cornerRadius = 10
        textField.font = .font(size: 18, weight: .medium, design: .rounded)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var passwordRequirementsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .font(size: 15, weight: .medium, design: .rounded)
        label.text = "Password must be longer than 6 characters"
        label.numberOfLines = 2
        return label
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
         [enterUsernameLabel,
          usernameTextField,
          enterEmailLabel,
          emailTextField,
          enterPasswordLabel,
          passwordTextField,
          passwordRequirementsLabel].forEach {
            addSubview($0)
        }
        
        enterUsernameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(enterUsernameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
        
        enterEmailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
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
        
        passwordRequirementsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func configureTextFieldDelegate(with viewController: UIViewController) {
        [usernameTextField, emailTextField, passwordTextField].forEach {
            guard let viewController = viewController as? UITextFieldDelegate else { return }
            $0.delegate = viewController
        }
    }
}
