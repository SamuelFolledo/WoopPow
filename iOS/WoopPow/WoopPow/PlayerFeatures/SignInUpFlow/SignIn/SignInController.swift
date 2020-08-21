//
//  SignInController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import NVActivityIndicatorView
import KeychainSwift
import FirebaseUI

class SignInController: UIViewController {
    
    // MARK: - Properties
    var coordinator: AppCoordinator!
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBackground
        view.frame = self.view.bounds
        let contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 100)
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsVerticalScrollIndicator = false
        view.bounces = true
        return view
    }()
    let contentView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .font(size: 30, weight: .bold, design: .default)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var formView: SignInFormView = {
        let view = SignInFormView()
        view.emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        view.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return view
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7) // default state
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .font(size: 16, weight: .semibold, design: .rounded)
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 22.5
        button.isEnabled = false // default state
        button.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .font(size: 17, weight: .medium, design: .rounded)
        button.addTarget(self, action: #selector(goToCreateAccountController), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        formView.configureTextFieldDelegate(with: self)
        hideKeyboardOnTap()
        configureAutoLayout()
        addKeyboardObservers()
    }
    
    // MARK: - Methods
    
    private func configureAutoLayout() {
        view.insertSubview(scrollView, at: 0)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.left.right.equalTo(view)
            $0.height.equalTo(scrollView.contentLayoutGuide.snp.height)
            $0.width.equalTo(scrollView.contentLayoutGuide.snp.width)
        }
        
        let stackView = UIStackView(arrangedSubviews: [], axis: .vertical, alignment: .leading, distribution: .fillProportionally, spacing: 20)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        [signInLabel, formView, signInButton, createAccountButton].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
            }
        }
        
        signInLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        formView.snp.makeConstraints {
            $0.height.equalTo(140)
        }
        
        signInButton.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        
        createAccountButton.snp.makeConstraints {
            $0.width.height.equalTo(signInButton)
        }
    }
    
    private func showErrorMessageAlertView(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - @ObjC Methods
    
    @objc fileprivate func goToCreateAccountController() {
        coordinator.goToCreateAccountController()
    }
    
    @objc func signInUser() {
        guard let email = formView.emailTextField.text?.trimWhiteSpacesAndLines,
              let password = formView.passwordTextField.text?.trimWhiteSpacesAndLines
        else { return }
        signInButton.isEnabled = !email.isEmpty && !password.isEmpty
        startActivityIndicator()
        //sign user in
        UserService.signIn(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                self.stopActivityIndicator()
                self.presentAlert(title: "Sign In Error", message: error.localizedDescription)
            case .success(let user):
                //get user type
                UserService.fetchUserType(userId: user.uid) { (result) in
                    switch result {
                    case .failure(let error):
                        self.stopActivityIndicator()
                        self.presentAlert(title: "Error Fetching User Type", message: error.localizedDescription)
                    case .success(let userType):
                        //save the user
                        Defaults.setUserType(userType, writeToUserDefaults: true)
                        Defaults.hasLoggedInOrCreatedAccount = true
                        switch userType {
                        case .Player:
                            var player = Player(userId: user.uid, username: user.displayName!, email: user.email!)
                            player.userType = userType
                            Player.setCurrent(player, writeToUserDefaults: true)
                            //go to home
                            self.coordinator.goToHomeController()
                        case .Admin:
                            print("Admin user type unsupported")
                            self.stopActivityIndicator()
                        }
                    }
                }
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let email = formView.emailTextField.text,
              let password = formView.passwordTextField.text,
            email.isEmpty || password.isEmpty else {
                signInButton.isEnabled = true
                signInButton.backgroundColor = .systemBlue
                return
        }
        signInButton.isEnabled = false
        signInButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
    }
}

extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case formView.emailTextField:
            formView.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: Keyboard methods
private extension SignInController {
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.height
        scrollView.contentInset.bottom = keyboardHeight + 50
    }
}
