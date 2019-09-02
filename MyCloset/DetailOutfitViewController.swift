//
//  DetailOutfitViewController.swift
//  MyCloset
//
//  Created by GraceToa on 16/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class DetailOutfitViewController: UIViewController {
    
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var collectionDetailOutfit: UICollectionView!
    @IBOutlet weak var seasonTitle: UILabel!
    
    var outfit: Outfit!
    var clothes: [Clothe] = []
    var clothesSet = Set<Clothe>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Style Me"
        note.layer.borderColor = UIColor.white.cgColor
        note.layer.borderWidth = 2
        note.layer.cornerRadius = 3
        
        let detailClothesCV = DetailClothesViewController()
        detailClothesCV.addIconLabel(icon: UIImage(named: "typeD.png")!, label: seasonTitle, word: "This outfit is perfect for:")
        
        if let outfit = outfit {
            season.text = outfit.name
            note.text = outfit.note
            ratingControl.rating = Int(outfit.rating)
            clothesSet = outfit.clothes!
            for c in clothesSet {
                clothes.append(c)
            }
        }
        
        //desig images
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionDetailOutfit.collectionViewLayout = layout
        collectionDetailOutfit.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
    //MARK: Private Methods
    
    @objc func imageTapped(sender: myTapGesture)  {
        let c = sender.clothe
        performSegue(withIdentifier: "ShowDetailClotheFromOutfit", sender: c)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailClotheFromOutfit" {
            let destin = segue.destination as! DetailClothesViewController
            destin.clothe = (sender as! Clothe)
            
        }
    }
}


extension DetailOutfitViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionDetailOutfit.dequeueReusableCell(withReuseIdentifier: "cellDetailOutfit", for: indexPath) as! ImagesCategCollectionViewCell
         let clothe = clothes[indexPath.row]
        let image = Data(referencing: clothe.image!)
        cell.imageDetailOutfit.image = UIImage(data: image as Data)
        //action image send object
        let tap = myTapGesture(target: self, action: #selector(imageTapped))
        cell.imageDetailOutfit.isUserInteractionEnabled = true
        cell.imageDetailOutfit.addGestureRecognizer(tap)
        tap.clothe = clothe
        return cell
    }
}

class myTapGesture: UITapGestureRecognizer {
    var clothe = Clothe()
}
