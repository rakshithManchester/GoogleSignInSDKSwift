//
//  ViewController.swift
//  GoogleSignInSDK
//
//  Created by rakshith appaiah on 3/30/18.
//  Copyright © 2018 rakshith appaiah. All rights reserved.
//

import UIKit
import GoogleSignIn
import Locksmith

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    /**
     Note: User instance.
     */
    var users = Users()
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Note:
         . GoogleSignIn ClientID
         . Assigning ViewController to GIDSignInDelegate
         . Assigning ViewController to GIDSignInUIDelegate
         */
        GIDSignIn.sharedInstance().clientID = GoogleSignInSDKConstants.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 7
        container.layer.masksToBounds = true
    }
    
    /**
     Note: Present a view that prompts the user to sign in with Google
     */
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    /**
     Note: Dismiss the "Sign in with Google" view
     */
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     Note: User credentials are handled.
     */
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            alertMessage(message: error.localizedDescription)
        } else {
            /**
             Note: Encrypting (userID,idToken,name,givenName,familyName,email) using Locksmith SDK
             */
            do {
                try  Locksmith.saveData(data: ["userID": user.userID, "idToken": user.authentication.idToken,"name": user.profile.name,"givenName": user.profile.givenName,"familyName": user.profile.familyName,"email": user.profile.email], forUserAccount: "USER")
            } catch {
                do {
                    try Locksmith.updateData(data: ["userID": user.userID, "idToken": user.authentication.idToken,"name": user.profile.name,"givenName": user.profile.givenName,"familyName": user.profile.familyName,"email": user.profile.email], forUserAccount: "USER")
                } catch {
                    
                }
            }
            // performSegue
            performSegue(withIdentifier: "tableVwSegue", sender:self)
        }
    }
}

extension ViewController {
     func alertMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

