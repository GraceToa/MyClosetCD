//
//  ListAllTableViewCell.swift
//  MyCloset
//
//  Created by GraceToa on 31/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ListAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var imageListAll: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
