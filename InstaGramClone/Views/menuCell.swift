//
//  menuCellTableViewCell.swift
//  InstaGramClone
//
//  Created by Siddharth Patel on 03/07/19.
//  Copyright © 2019 solutionanalysts. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblMenuName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
