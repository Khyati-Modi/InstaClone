//
//  NewFeedsTableViewCell.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 01/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class NewFeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var imgPost: UIImageView!
    
    let settings = FirestoreSettings()
     var db:Firestore!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
         
    }
    
    
    @IBAction func onDeleteBtnClick(_ sender: Any) {
        self.deeletPosts()
    }
    
    @IBAction func onEditBtnClick(_ sender: Any) {
        
    }
    
    func deeletPosts(){
        db.collection("Caption").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.data()["captions"] as? String == self.lblCaption.text
                    {
                        self.db.collection("Caption").document(document.documentID).delete()
                    }
                }
            }
        }
    }
}
/*
 
 func deleteField() {
 // [START delete_field]
 db.collection("Caption").document().updateData([
 "captions": FieldValue.delete()
 ]) { err in
 if let err = err {
 print("Error updating document: \(err)")
 } else {
 print("Document successfully updated")
 }
 }
 // [END delete_field]
 }
 
 */
