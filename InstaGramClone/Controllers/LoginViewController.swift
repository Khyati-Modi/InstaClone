//
//  ViewController.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 01/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {
 
    @IBOutlet weak var viewInstaBackGround: UIView!
    @IBOutlet weak var btnFaceookLogin: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.purple.cgColor,UIColor.red.cgColor]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        viewInstaBackGround.layer.addSublayer(layer)
        btnFaceookLogin.delegate = self as LoginButtonDelegate
        
        if UserDefaults.standard.bool(forKey: "login") == true {
            let viewController:MainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
   
 //Unuse Button
    @IBAction func onBtnFacbookLoginClick(_ sender: Any) {
     
       
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print("Error: ->\(error.localizedDescription)")
            return
        }else {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error != nil {
                    print("logged in")
                    return
                }else{
                    print("not logged in")
                }
            }
        }
        let viewController:MainTabViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        UserDefaults.standard.set(true, forKey: "login")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        print("logged out")
    }
}


//https://github.com/cruisediary/Pastel
//https://stackoverflow.com/questions/41680946/how-to-apply-gradient-to-uiview-in-ios-10-on-a-real-device
//auth redirect url
//https://fir-social-login-26848.firebaseapp.com/__/auth/handler
//https://github.com/drawRect/Instagram_Stories
//https://www.youtube.com/watch?v=3E1NoU-LGrM
//https://www.youtube.com/watch?v=jaXlbR90jrk&list=PLaXWdRaxFtVcgioOVP6UxFt43KQ6Gjur_
//https://github.com/firebase/snippets-ios/blob/fa4eb920c706665f8503b9f67f6d4a4b8c9ae65e/firestore/swift/firestore-smoketest/AppDelegate.swift#L31-L33
