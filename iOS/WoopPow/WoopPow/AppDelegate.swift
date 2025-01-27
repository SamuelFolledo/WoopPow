//
//  AppDelegate.swift
//  WoopPow
//
//  Created by Samuel Folledo on 7/27/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import FirebaseCore
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    ///Required method for Google Auth
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool { //3/5 Google Signin
        return GIDSignIn.sharedInstance().handle(url)
    }

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        // ...
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//                print("The user has not signed in before or they have since signed out.")
//            } else {
//                print("AppDelegate Error with Google Signin \(error.localizedDescription)")
//            }
//            return
//        }
//        // Perform any operations on signed in user here.
//        let userId = user.userID // For client-side use only!
//        let idToken = user.authentication.idToken // Safe to send to the server
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
//        print("User we have from App Delegate's Google Signin = \(String(describing: fullName))")
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        print("AppDelegate got Google Sigin credential \(credential)")
//        // ...
//    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) { //5/5 Google Signin
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
