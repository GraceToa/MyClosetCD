//
//  ClothesCollectionViewController.swift
//  MyCloset
//
//  Created by GraceToa on 12/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ClothesCollectionViewController: UIViewController {
    
    @IBOutlet var collectionC: UICollectionView!
    
    var images: [Image] = []
    var clothes: [Clothe] = []
    var arrSelectedIndex = [IndexPath]()
    var arrSelectData = [Clothe]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clothes = Clothe.getAllClothes()
        //desig images
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        collectionC.collectionViewLayout = layout
        collectionC.allowsMultipleSelection = true
      
    }
    
    
    // MARK: Private Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destin = segue.destination as! AddOutfitViewController
        destin.clothes = arrSelectData
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource

extension ClothesCollectionViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionC.dequeueReusableCell(withReuseIdentifier: "cellClothes", for: indexPath) as! ImagesCategCollectionViewCell
        let clothe = clothes[indexPath.row]
        
        let image = Data(referencing: clothe.image!)
        cell.imageCollection.image = UIImage(data: image as Data)
        
        if arrSelectedIndex.contains(indexPath) {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.blue.cgColor
        }else {
            cell.layer.borderWidth = 0
        }
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let srtData = clothes[indexPath.item]
        if arrSelectedIndex.contains(indexPath){
            arrSelectedIndex = arrSelectedIndex.filter {$0 != indexPath}
            arrSelectData = arrSelectData.filter { $0 != srtData}
        } else {
            arrSelectedIndex.append(indexPath)
            arrSelectData.append(srtData)
        }
        collectionView.reloadData()
    }
}
