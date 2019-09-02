//
//  DetailClothesViewController.swift
//  MyCloset
//
//  Created by GraceToa on 31/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class DetailClothesViewController: UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ocassion: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var typeTitle: UILabel!
    @IBOutlet weak var ocassionTitle: UILabel!
    @IBOutlet weak var seasonTitle: UILabel!
    
    var clothe: Clothe!
    var idClothes: Int16 = 0
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clothe.category
                
        addIconLabel(icon: UIImage(named: "categoryD.png")!, label: categoryTitle, word: "This piece is: ")
        addIconLabel(icon: UIImage(named: "typeD.png")!, label: typeTitle, word: "Of type:")
        addIconLabel(icon: UIImage(named: "ocassionD.png")!, label: ocassionTitle, word: "For the ocassion:")
        addIconLabel(icon: UIImage(named: "seasonD.png")!, label: seasonTitle, word: "Can you wear is: ")

        category.text = clothe.category
        type.text = clothe.type
        ocassion.text = clothe.ocassion
        season.text = clothe.season
        ratingControl.rating = Int(clothe.rating)
        idClothes = clothe.id
        
        let img = Data(referencing: clothe.image!)
        imageDetail.image = UIImage(data: img)
        
        //asign an action for UIImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageDetail.isUserInteractionEnabled = true
        imageDetail.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: Private Methods

   @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)  {    
        performSegue(withIdentifier: "ShowImg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImg" {
            let destin = segue.destination as! DetailImageViewController
            destin.clothe = clothe
        }
    }
    
    func addIconLabel(icon: UIImage, label: UILabel, word: String)  {
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = icon
        let imageOffsetY:CGFloat = -2.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let  textAfterIcon = NSMutableAttributedString(string: word)
        completeText.append(textAfterIcon)
        label.textAlignment = .center;
        label.attributedText = completeText;
    }
}
