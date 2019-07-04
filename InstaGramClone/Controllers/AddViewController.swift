//
//  AddViewController.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 01/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit
import Firebase
import SideMenu


class AddViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtCaption: UITextView!
    @IBOutlet weak var imgPost: UIImageView!
    
    var db:Firestore!
    var captions = [AddCaption]()
    var docIDs:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        self.navigationItem.setHidesBackButton(true, animated:true)
        setupSideMenu()
    }
    
    //MARK: - Add AND UPDATE From Firebase Metods
    func addCaption(){
        let captionText = txtCaption.text!
        var ref: DocumentReference? = nil
        ref = db.collection("Caption").addDocument(data: [
            "captions": captionText
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        print("siddharth:\(docIDs = ref!.documentID)")
        
    }
    
    func UpdateCaptions(){
        
        db.collection("Caption").document().updateData([
            "captions": txtCaption.text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //MARK: - Selector for naviagtion button
    @objc func onBtnCancelClick(){
        
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - IBAction of button
    @IBAction func onShareBtnClick(_ sender: Any) {
        addCaption()
        UploadImage()
    }
    
    @IBAction func onBtnAddImageClick(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            print("worked")
            let imagePickerView = UIImagePickerController()
            imagePickerView.delegate = self
            imagePickerView.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePickerView.allowsEditing = false
            self.present(imagePickerView, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func onBtnAddVideoClick(_ sender: Any) {
               let viewController:HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - for upload data to firebase (Image)
    func UploadImage(){
            let uploadRef = Storage.storage().reference(withPath: "Posts/\(docIDs).jpg")
            guard let imageData = imgPost.image?.jpegData(compressionQuality: 0.75) else{ return }
            let uploadMetaData = StorageMetadata.init()
            uploadMetaData.contentType = "image/jpeg"
            uploadRef.putData(imageData, metadata: uploadMetaData, completion: {(downloadMetaData, error) in
                if let error = error {
                    print("got an error \(error.localizedDescription)")
                    return
                }
                print("completed \(String(describing: downloadMetaData))")
            })
    }
    
    @IBAction func onAddBtnClick(_ sender: Any) {
        
    }
    
    //MARK: - SlideMenu
    func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}

//MARK: - Extension Of UIImage Delegate
extension AddViewController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgPost.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UISideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}


//https://firebase.google.com/docs/firestore/quickstart?authuser=0
//https://codelabs.developers.google.com/codelabs/firestore-ios/#3
//https://console.firebase.google.com/project/fir-social-login-26848/database/firestore/rules
//https://codelabs.developers.google.com/codelabs/firestore-ios/#3
//https://firebase.googleblog.com/2016/07/5-tips-for-firebase-storage.html
//https://code.tutsplus.com/tutorials/get-started-with-firebase-storage-for-ios--cms-30203
//https://www.appcoda.com/firebase/
//https://stackoverflow.com/questions/48077932/can-i-upload-posts-with-the-same-auto-id-swift-4-firebase
//https://click.linksynergy.com/deeplink?id=sGnlDIn59ks&mid=39197&murl=http://www.udemy.com/instagram-clone-w-swift-4-firebase-and-push-notifications/
//https://stackoverflow.com/questions/39947076/uitableviewcell-buttons-with-action

/*
 
 reference.downloadURL(completion: { (url, error) in
 if let error = error { return }
 // 6
 })
 */
