//
//  ImagesCategCollectionViewController.swift
//  MyCloset
//
//  Created by GraceToa on 05/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ImagesCategCollectionViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var images: [Image] = []
    var clothes: [Clothe] = []
    var category: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category
        clothes = Clothe.getAllClothesForCategory(category: category!)
        
        //desig images
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collection.collectionViewLayout = layout
        collection.contentInsetAdjustmentBehavior = .never
    }
}

extension ImagesCategCollectionViewController: UICollectionViewDelegate ,UICollectionViewDataSource{
    
    // MARK: UICollectionDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cellImgsCateg", for: indexPath) as! ImagesCategCollectionViewCell
        let clothe = clothes[indexPath.row]
        let image = Data(referencing: clothe.image!)
        cell.image.image = UIImage(data: image as Data)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowImageDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowImageDetail" {
            let id = sender as! NSIndexPath
            let rowClothes  = clothes[id.row]
            let destin = segue.destination as! DetailClothesViewController
            destin.clothe = rowClothes
        }
    }
}
