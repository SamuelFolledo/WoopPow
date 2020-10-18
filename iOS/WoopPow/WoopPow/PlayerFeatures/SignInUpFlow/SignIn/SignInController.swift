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
import GoogleSignIn

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
        label.textColor = .label
        label.font = FontManager.setFont(size: 32, fontType: .black)
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
        button.backgroundColor = UIColor.systemGray2
        button.isEnabled = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = FontManager.setFont()
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
    
    let googleSigninButton: UIButton = {
        let button = UIButton()
        //        button.style = .wide
        button.backgroundColor = .systemBackground
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = FontManager.setFont()
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 3
        button.layer.cornerRadius = 22.5
        button.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? Sign Up.", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = FontManager.setFont()
        button.addTarget(self, action: #selector(goToCreateAccountController), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        transparentNavigationBar()
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
        
        [signInLabel, formView, signInButton, googleSigninButton, createAccountButton].forEach {
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
        
        googleSigninButton.snp.makeConstraints {
            $0.width.height.equalTo(signInButton)
        }
        
        let googleImageView = UIImageView(image: UIImage(named: "googleLogo"))
        googleSigninButton.addSubview(googleImageView)
        googleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(googleSigninButton.snp.height).multipliedBy(0.6)
            $0.left.equalToSuperview().offset(20)
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
    
    fileprivate func setupUserName(title: String = "Choose your username") {
        presentAlertWithField(title: title, inputPlaceholder: "Enter your username", inputKeyboardType: .default,
        cancelHandler: { (_) in
            print("Canceled")
            UserService.deleteUser()
            return
        }) { (username) in
            guard let username = username else { return }
            //check if username exist
            db.collection(UsersKeys.Collection.Users).whereField(UsersKeys.UserInfo.username, isEqualTo: username).getDocuments { (snapshot, error) in
                if let error = error {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                guard let snapshot = snapshot else { return }
                if snapshot.isEmpty { //if username does not exist
                    let userData = [UsersKeys.UserInfo.username: username]
                    UserService.updateUserData(userData: userData) { (error) in
                        if let error = error {
                            self.presentAlert(title: "Error Updating Username", message: error)
                            return
                        }
                        self.coordinator.goToHomeController()
                    }
                } else {
                    print("Username already exist please try again")
                    self.stopActivityIndicator()
                    self.setupUserName(title: "Username is already taken")
                }
            }
        }
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
                            PlayerService.fetchPlayer(userId: user.uid) { (result) in
                                switch result {
                                case .failure(let error):
                                    self.stopActivityIndicator()
                                    self.presentAlert(title: "Error Fetching User Type", message: error.localizedDescription)
                                case .success(let player):
                                    Player.setCurrent(player, writeToUserDefaults: true)
                                    //go to home
                                    self.coordinator.goToHomeController()
                                }
                            }
                        case .Admin:
                            print("Admin user type unsupported")
                            self.stopActivityIndicator()
                        }
                    }
                }
            }
        }
    }
    
    @objc func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
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
        signInButton.backgroundColor = UIColor.systemGray2
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

//MARK: Google Signin Delegate Methods
extension SignInController: GIDSignInDelegate {
    func signInWillDispatch(_ signIn: GIDSignIn!, error: Error!) {
        print("GOOGLE SIGNIN WILL DISPATCH?")
    }
    
    func signIn(_ signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) { //presents the google signin screen
        print("Presenting VC")
        startActivityIndicator()
        self.present(viewController, animated: true, completion: nil)
    }
    
    func signIn(_ signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) { //when user dismisses the google signin screen
        startActivityIndicator()
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            stopActivityIndicator()
            if error.localizedDescription == "The user canceled the sign-in flow." {
                print("User Canceled Google Auth")
            } else {
                presentAlert(title: "Google Signin Error", message: error.localizedDescription)
            }
            return
        }
        var userDictionary = [
//            UsersKeys.UserInfo.username: user.profile.givenName ?? "",
//            UsersKeys.UserInfo.lastName: user.profile.familyName ?? "",
            UsersKeys.UserInfo.email: user.profile.email ?? "",
            UsersKeys.UserInfo.userType: UserType.Player.rawValue,
        ]
        
        if user.profile.hasImage {
            userDictionary[UsersKeys.UserInfo.photoUrl] = user.profile.imageURL(withDimension: 100)?.absoluteString
            print("Image URL from Google = \(userDictionary[UsersKeys.UserInfo.photoUrl]!)")
        }
        guard let authentication = user.authentication else {
            self.stopActivityIndicator()
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken) //are we goin to need a session token
        
        UserService.authenticateUser(credential: credential, userDictionary: userDictionary) { (result) in //authenticate user with credentials and get user
            self.stopActivityIndicator()
            switch result {
            case .failure(let error):
                self.presentAlert(title: "Google Error", message: error.localizedDescription)
            case .success(let isNewUser):
                if isNewUser {
                    self.setupUserName()
                } else {
                    self.coordinator.goToHomeController()
                }
            }
        }
    }
}
