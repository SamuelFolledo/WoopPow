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
        label.textAlignment = .left
        label.font = .font(size: 16, weight: .bold, design: .default)//UIFont(name: "Avenir-Heavy", size: 18)
        label.text = "Email or Username"
        label.numberOfLines = 1
        return label
    }()
    
    let emailTextField: UnderlinedTextField = {
        let textField = UnderlinedTextField()
        textField.placeholder = "Enter email or username"
        textField.font = .font(size: 18, weight: .medium, design: .rounded)
        textField.textColor = UIColor.label
//        textField.backgroundColor = UIColor(r: 242, g: 242, b: 242, a: 1)
//        textField.setPadding(left: 15, right: 15)
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
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
        textField.textColor = UIColor.label
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.textContentType = .password
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

