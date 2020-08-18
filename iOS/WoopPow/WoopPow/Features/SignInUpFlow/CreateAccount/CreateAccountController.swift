//
//  CreateAccountController.swift
//  WoopPow
//
//  Created by Samuel Folledo on 8/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
//import KeychainSwift
//import NVActivityIndicatorView
//import SafariServices
import FirebaseAuth

class CreateAccountController: UIViewController {
    
    // MARK: - Properties
    let validityType: String.ValidityType = .password
    
    // MARK: - UI Components
    
    let createYourAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.textAlignment = NSTextAlignment.left
//        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.textColor = .black
        label.font = .font(size: 30, weight: .bold, design: .default)
        label.numberOfLines = 2
        return label
    }()
    
    private let formView = CreateAccountFormView()
    
    private lazy var creatingAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "By creating your account, you agree to our"
        label.textAlignment = .left
        label.font = .font(size: 16, weight: .medium, design: .default)
        label.textColor = .black
        return label
    }()
    
    private let termsAndConditionsButton: UIButton = {
        let headlineAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.font(size: 16, weight: .semibold, design: .default),
            NSAttributedString.Key.foregroundColor : UIColor.bolarLightBlue
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
    
    private let privacyPolicyButton: UIButton = {
        let headlineAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.font(size: 16, weight: .semibold, design: .default),
            NSAttributedString.Key.foregroundColor : UIColor.bolarLightBlue
        ]
        let headlineText = NSMutableAttributedString(string: "• Privacy Policy", attributes: headlineAttributes)
        let combination = NSMutableAttributedString()
        combination.append(headlineText)
        let button = UIButton(type: .system)
        button.setAttributedTitle(combination, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handlePrivacyPolicy), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .bolarLightBlue
        button.setImage(UIImage(named: "white-right-arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)
        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.bolarBlack.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 3
        button.addTarget(self, action: #selector(presentDriversLicenseVerificationPromptController), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        formView.configureTextFieldDelegate(with: self)
        configureAutoLayout()
        configureNavigationItem()
        configureTapRecognizer()
    }
    
    private func configureAutoLayout() {
        [createYourAccountLabel, formView, creatingAccountLabel, termsAndConditionsButton, privacyPolicyButton, nextButton].forEach {
            view.addSubview($0)
        }
        
        createYourAccountLabel.snp.makeConstraints { (make) in
//            make.height.equalTo(25)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.right.equalTo(view.snp.right).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        formView.snp.makeConstraints { (make) in
            make.top.equalTo(createYourAccountLabel.snp.bottom).offset(40)
            make.height.equalToSuperview().multipliedBy(0.45)
            make.right.equalTo(view.snp.right).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        creatingAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(formView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        termsAndConditionsButton.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(creatingAccountLabel.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        privacyPolicyButton.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(termsAndConditionsButton.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        
    }
    
    private func startActivityIndicator() {
        let size = CGSize(width: 20, height: 20)
        let position = CGPoint(x: nextButton.frame.midX, y: nextButton.frame.midY)
        let frame = CGRect(origin: position, size: size)
        Constants.Views.indicatorView = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: .white, padding: 0)
        Constants.Views.indicatorView?.center = nextButton.center
        nextButton.addSubview(Constants.Views.indicatorView!)
        Constants.Views.indicatorView!.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        UIView.animate(withDuration: 0.2) {
            self.nextButton.isUserInteractionEnabled = false
            self.nextButton.backgroundColor = UIColor.bolarLightBlue.withAlphaComponent(0.7)
            self.nextButton.setImage(nil, for: .normal)
            self.view.isUserInteractionEnabled = false
            Constants.Views.indicatorView?.startAnimating()
        }

    }
    
    private func stopActivityIndicator() {
        UIView.animate(withDuration: 0.2) {
            self.nextButton.setImage(UIImage(named: "white-right-arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.nextButton.isUserInteractionEnabled = true
            self.nextButton.backgroundColor = .bolarLightBlue
        }
        self.view.isUserInteractionEnabled = true
        Constants.Views.indicatorView?.stopAnimating()
        Constants.Views.indicatorView?.removeFromSuperview()
    }

    
    private func configureNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(dismissCreateAccountController))
    }
    
//    private func handleTextFieldChanges() {
//        formView.emailTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//        formView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//    }
    
    private func configureTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddAdditionalCompanyInformationController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    private func createTenantUser(with email: String, password: String, name: String) {
        startActivityIndicator()
        TenantService.createUser(withEmail: email, password: password, name: name) { (result) in
            switch result {
            case .success(let tenant):
                guard let email = tenant.email,
                      let userId = tenant.userId,
                      let name = tenant.name
                else { return }
                self.createCustomer(userType: .Tenant, userId: userId, email: email, name: name)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.showErrorMessageAlertView(error: error)
                }
            }
        }
    }
    
    private func createLandlordUser(with email: String, password: String, name: String) {
        startActivityIndicator()
        LandlordService.createUser(withEmail: email, password: password, name: name) { (result) in
            switch result {
            case .success(let landlord):
                guard let email = landlord.email,
                      let userId = landlord.userId,
                      let name = landlord.name
                else { return }
                self.createCustomer(userType: .Landlord, userId: userId, email: email, name: name)
        
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.showErrorMessageAlertView(error: error)
                }
            }
        }
    }
    
    fileprivate func createCustomer(userType: UserType, userId: String, email: String, name: String) {
        FirestoreService.createCustomer(userId: userId, email: email, name: name, type: userType, environment: .production) {
            if let user = Auth.auth().currentUser {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        self.presentAlert(title: "Failed to Update Name", message: error.localizedDescription)
                        self.stopActivityIndicator()
                        return
                    }
                    DispatchQueue.main.async {
                        self.stopActivityIndicator()
                        switch userType {
                        case .Tenant:
                            let vc = DriversLicenseVerificationPromptController()
                            self.navigationController?.pushViewController(vc, animated: true)

                        case .Landlord:
                            DispatchQueue.main.async {
                                self.stopActivityIndicator()
                                let vc = LandlordTypeController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        default: break
                        }
                    }
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
    
    @objc func presentDriversLicenseVerificationPromptController() {
        guard let name = formView.nameTextField.text,
              let email = formView.emailTextField.text?.trimWhiteSpacesAndLines,
              let password = formView.passwordTextField.text
//            email.contains("@") && password.count > 8 && !password.isEmpty
        else { return }
        guard let account = Defaults.valueOfAccountType(),
              let accountType = UserType(rawValue: account)
        else { return }
        
        let keychain = KeychainSwift()
        keychain.set(password, forKey: Constants.securedPass)
        
        switch accountType {
        case .Tenant:
            createTenantUser(with: email, password: password, name: name)
        case .Landlord:
            createLandlordUser(with: email, password: password, name: name)
        default: break
        }
    }
    
    @objc func dismissCreateAccountController() {
        Defaults._removeUser(true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
//    @objc func textFieldDidChange(textField: UITextField) {
//        guard let email = formView.emailTextField.text,
//              let password = formView.passwordTextField.text,
//              let name = formView.nameTextField.text
//        else { return }
//        nextButton.alpha = 0.6
//
//        nextButton.isEnabled = !email.isEmpty && !password.isEmpty && !name.isEmpty
//    }
    
    @objc func handleTermsAndConditions() {
        guard let url = URL(string: Constants.URLs.termsAndConditions) else { return }
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let controller = SFSafariViewController(url: url, configuration: configuration)
        controller.delegate = self
        navigationController?.present(controller, animated: true)
    }
    
    @objc private func handlePrivacyPolicy() {
        guard let url = URL(string: Constants.URLs.privacyPolicy) else { return }
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let controller = SFSafariViewController(url: url, configuration: configuration)
        controller.delegate = self
        navigationController?.present(controller, animated: true)
    }
}

extension CreateAccountController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.dismiss(animated: true)
    }
}

extension CreateAccountController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var formViewY: CGFloat = 0
        var nextButtonY: CGFloat = 0
        switch textField {
        case self.formView.emailTextField:
            formViewY = -70
            nextButtonY = 0
        case self.formView.passwordTextField:
            formViewY = -160
            nextButtonY = -50
        default:
            formViewY = 0
            nextButtonY = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: formViewY)
            self.nextButton.transform = CGAffineTransform(translationX: 0, y: nextButtonY)
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case formView.nameTextField:
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


