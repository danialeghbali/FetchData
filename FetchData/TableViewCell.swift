//
//  TableViewCell.swift
//  FetchData
//
//  Created by danial eghbali on 12/8/18.
//  Copyright © 2018 danial eghbali. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgProductImage: UIImageView!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
