//
//  OutfitsTableViewCell.swift
//  MyCloset
//
//  Created by GraceToa on 15/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class OutfitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var imageOutfit: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
