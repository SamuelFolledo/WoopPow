//
//  UIViewController+Extensions.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit.UIViewController
import NVActivityIndicatorView

extension UIViewController {
    
    //takes a view and add
    func startActivityIndicator(type: NVActivityIndicatorType = .ballClipRotateMultiple) {
        let frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let activityIndicator = NVActivityIndicatorView(frame: frame, type: type, color: .label, padding: 0.0)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        UIView.animate(withDuration: 0.2) {
            self.view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        UIView.animate(withDuration: 0.2) {
            self.view.isUserInteractionEnabled = true
        }
        self.view.isUserInteractionEnabled = true
        Constants.Views.indicatorView.stopAnimating()
        Constants.Views.indicatorView.removeFromSuperview()
    }
    
    ///Transparent Navigation Bar
    func transparentNavigationBar() {
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func removeTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    ///remove keyboard when view is tapped
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentAlert(title: String, message: String = "") {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    }
}
