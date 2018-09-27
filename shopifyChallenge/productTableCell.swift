//
//  productTableCell.swift
//  shopifyChallenge
//
//  Created by Luna Cao on 2018/9/22.
//  Copyright © 2018年 Luna Cao. All rights reserved.
//

import UIKit

class productTableCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var variants: UILabel!
    
    @IBOutlet weak var timeSent: UILabel!
    
    @IBOutlet weak var imageOne: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
