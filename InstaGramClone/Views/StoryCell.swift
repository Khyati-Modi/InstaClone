//
//  StoryCell.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 01/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCellBackGround: UIView!
    @IBOutlet weak var lblCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         viewCellBackGround.layer.cornerRadius = viewCellBackGround.frame.size.height/2
    }
}
