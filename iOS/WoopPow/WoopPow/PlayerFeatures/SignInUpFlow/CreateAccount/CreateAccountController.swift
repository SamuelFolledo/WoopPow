//
//  CreateAccountController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import KeychainSwift
import NVActivityIndicatorView
//import SafariServices
import FirebaseAuth

class CreateAccountController: UIViewController {
    
    // MARK: - Properties
    var coordinator: AppCoordinator!
    
    // MARK: - UI Components
    
    private lazy var backButton: UIButton = {
        let button = AppService.backButton()
        return button
    }()
    
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
    
    let createYourAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.textAlignment = NSTextAlignment.left
        label.textColor = .label
        label.font = FontManager.setFont(size: 32, fontType: .black)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var formView: CreateAccountFormView = {
        let view = CreateAccountFormView()
        view.usernameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        view.emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        view.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        return view
    }()
    
    private lazy var creatingAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "By creating your account, you agree to our"
        label.textAlignment = .left
        label.font = FontManager.setFont(size: 16, fontType: .medium)
        label.textColor = .label
        return label
    }()
    
    private let termsAndConditionsButton: UIButton = {
        let headlineAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: FontManager.setFont(size: 18, fontType: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        let headlineText = NSMutableAttributedString(string: "• Terms & Conditions", attributes: headlineAttributes)
        let combination = NSMutableAttributedString()
        combination.append(headlineText)
        let button = UIButton(type: .system)
        button.setAttributedTitle(combination, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleTermsAndConditions), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = FontManager.setFont()
        button.backgroundColor = UIColor.systemGray.withAlphaComponent(0.7)
        button.isEnabled = false
        button.imageEdgeInsets = UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 3
        button.addTarget(self, action: #selector(goToNextController), for: .touchUpInside)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = FontManager.setFont()
        button.backgroundColor = UIColor.clear
        button.imageEdgeInsets = UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(goToSigninController), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Already have an account?", for: .normal)
        return button
    }()
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        transparentNavigationBar()
        addBackButton()
        formView.configureTextFieldDelegate(with: self)
        configureAutoLayout()
        hideKeyboardOnTap()
        addKeyboardObservers()
    }
    
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
        
        let tocStackView = UIStackView(arrangedSubviews: [creatingAccountLabel, termsAndConditionsButton], axis: .vertical, alignment: .leading, distribution: .fill, spacing: 5)
        
        [createYourAccountLabel, formView, tocStackView, nextButton, alreadyHaveAccountButton].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
            }
        }
        
        createYourAccountLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        formView.snp.makeConstraints {
            $0.height.equalTo(230)
        }
        
        tocStackView.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        creatingAccountLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        termsAndConditionsButton.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        alreadyHaveAccountButton.snp.makeConstraints {
            $0.height.width.equalTo(nextButton)
        }
    }
    
    @objc fileprivate func goToSigninController() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
//    private func handleTextFieldChanges() {
//        formView.emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//        formView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//    }
    
    private func createPlayerUser(with email: String, password: String, username: String) {
        PlayerService.createUser(withEmail: email, password: password, username: username) { (result) in
            self.stopActivityIndicator()
            switch result {
            case .success(let player):
                print("\(player.username!) successfully created an account")
                DispatchQueue.main.async {
                    self.coordinator.goToHomeController()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorMessageAlertView(error: error)
                }
            }
        }
    }
    
    private func showErrorMessageAlertView(error: Error) {
        guard let errorCode = AuthErrorCode(rawValue: error._code) else { return }
        var message = ""
        switch errorCode {
        case .invalidEmail:
            message = "The entered email is invalid."
        case .emailAlreadyInUse:
            message = "The entered email is already in use. Try another email!"
        case .weakPassword:
            message = "Your password needs to be greater than 6 characters."
        case .networkError:
            message = "Oops! There's a problem with creating your account. Make sure you have a strong internet connection and try again!"
        case .providerAlreadyLinked:
            message = "An email is already linked to your phone number."
        default:
            message = error.localizedDescription
        }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - @objc Selector Methods
    
    @objc func goToNextController() {
        startActivityIndicator()
        guard let username = formView.usernameTextField.text,
              let email = formView.emailTextField.text?.trimWhiteSpacesAndLines,
              let password = formView.passwordTextField.text
        else { return }
        //check if username already exist
        db.collection(UsersKeys.Collection.Users).whereField(UsersKeys.UserInfo.username, isEqualTo: username).getDocuments { (snapshot, error) in
            if let error = error {
                self.stopActivityIndicator()
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            guard let snapshot = snapshot else { return }
            if snapshot.isEmpty { //if username does not exist, store password and create user
                let keychain = KeychainSwift()
                keychain.set(password, forKey: Constants.password)
                self.createPlayerUser(with: email, password: password, username: username)
            } else { //username is already taken
                self.stopActivityIndicator()
                self.formView.usernameTextField.hasError()
                self.presentAlert(title: "User is already taken")
            }
        }
    }
    
    @objc func dismissCreateAccountController() {
        Defaults._removeUser(true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTermsAndConditions() {
//        guard let url = URL(string: Constants.URLs.termsAndConditions) else { return }
//        let configuration = SFSafariViewController.Configuration()
//        configuration.entersReaderIfAvailable = true
//        let controller = SFSafariViewController(url: url, configuration: configuration)
//        controller.delegate = self
//        navigationController?.present(controller, animated: true)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let username = formView.usernameTextField.text,
              let email = formView.emailTextField.text,
              let password = formView.passwordTextField.text,
              email.isEmpty || password.isEmpty || username.isEmpty else {
                nextButton.isEnabled = true
                nextButton.backgroundColor = .systemBlue
                return
        }
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.7)
    }
}

//extension CreateAccountController: SFSafariViewControllerDelegate {
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        navigationController?.dismiss(animated: true)
//    }
//}

extension CreateAccountController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case formView.usernameTextField:
            formView.emailTextField.becomeFirstResponder()
        case formView.emailTextField:
            formView.passwordTextField.becomeFirstResponder()
        case formView.passwordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: Keyboard methods
private extension CreateAccountController {
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
        scrollView.contentInset.bottom = keyboardHeight + 30
    }
}
