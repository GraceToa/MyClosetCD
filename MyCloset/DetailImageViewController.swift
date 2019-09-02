//
//  DetailImageViewController.swift
//  MyCloset
//
//  Created by GraceToa on 07/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var clothe: Clothe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = Data(referencing: clothe.image!)
        image.image = UIImage(data: img)
        
    }
}
