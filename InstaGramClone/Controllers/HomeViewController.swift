//
//  HomeViewController.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 01/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var collctionViewStory: UIView!
    
    var captions = [AddCaption]()
    var db:Firestore!
    let settings = FirestoreSettings()
    var docID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        getCollection()
        print("document id\(docID)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getCollection()
         self.tblHome.reloadData()
    }
    
 //MARK: - Add AND UPDATE From Firebase Metods
    private func getCollection() {
     self.captions.removeAll()
        db.collection("Caption").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let addCaption = AddCaption()
                    addCaption.caption.append(document.data()["captions"] as! String)
                    
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "Posts/\(document.documentID).jpg")
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            addCaption.imgPost  = UIImage(data: data)!
                        }
                    })
                    self.captions.append(addCaption)
                    DispatchQueue.main.async {
                      self.tblHome.reloadData()
                        
                    }
                    self.tblHome.reloadData()
                    print(self.captions)
                    print("Data Print:- \(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

//MARK: - Extension Of UITable Datasource and Delegaet
extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return captions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = Bundle.main.loadNibNamed("NewFeedsTableViewCell", owner: self, options: nil)?.first as! NewFeedsTableViewCell
          cell.lblCaption.text = captions[indexPath.row].caption
          cell.imgPost.image = captions[indexPath.row].imgPost
          return cell
    }
    
}
extension HomeViewController:UITableViewDelegate{
    
}

//MARK: - Extension Of UICollcetionView Datasource and Delegate
extension HomeViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
        cell.lblCount.text = "1"
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//               let data = captions[indexPath.row]
//               let viewController:AddViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
//               viewController.captionsUpdate = data
//               self.navigationController?.showDetailViewController(viewController, sender: self)
    }
}


//https://stackoverflow.com/questions/50012956/firestore-how-to-store-reference-to-document-how-to-retrieve-it
//https://stackoverflow.com/questions/44060518/uploading-image-to-firebase-storage-and-database
// self.docID = document.documentID
//print("doc id : \(self.docID)")
//UserDefaults.standard.set(false, forKey: "login")
//UserDefaults.standard.set(true, forKey: "login")
// star resubale component :https://www.twilio.com/blog/2018/06/build-reusable-ios-components-swift.html
