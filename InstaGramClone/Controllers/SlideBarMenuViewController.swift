//
//  SlideBarMenuViewController.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 03/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit
import SideMenu
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class SlideBarMenuViewController: UIViewController {
    
    let menuArray = ["Home","Share","Logout"]
    let identities = ["MainTabViewController"]
    //let menuImages = ["ic_home.pdf","ic_share.png","ic_logout.png"]
    @IBOutlet weak var tblMenuItem: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "menuCell", bundle: nil)
        tblMenuItem.register(nib, forCellReuseIdentifier: "menuCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblMenuItem.reloadData()
    }

}

extension SlideBarMenuViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! menuCell
        cell.lblMenuName.text = menuArray[indexPath.row]
        //cell.imgIcon.image = menuImages[indexPath.row]
        return cell
    }
    
}

extension SlideBarMenuViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vcName = identities[indexPath.row]
            let viewcontroller = storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewcontroller!, animated: true)
        }else if indexPath.row == 1 {
            
        }else if indexPath.row == 2 {
            do{
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().currentUser?.link(with:credential,completion:nil)
                try! Auth.auth().signOut()
                Auth.auth().signInAnonymously()
                LoginManager().logOut()
                print("Logged Out Successfully")
            }catch{
                print("User Sign Out Error : \(error)")
            }
            UserDefaults.standard.set(false, forKey:"Logged In")
            self.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
            }
        }
}

