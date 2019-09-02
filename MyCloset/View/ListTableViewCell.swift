//
//  ListTableViewCell.swift
//  MyCloset
//
//  Created by GraceToa on 28/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet {
            backgroundImage.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var backgroundColorView: UIView! {
        didSet {
            backgroundColorView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
