//
//  AddOutfitsViewController.swift
//  MyCloset
//
//  Created by GraceToa on 12/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class AddOutfitViewController: UIViewController {
    
    @IBOutlet weak var addSeason: UIButton!
    @IBOutlet weak var tableSeason: UITableView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var collectionOutfits: UICollectionView!
    @IBOutlet weak var note: UITextView!
    
    var clothes: [Clothe] = []
    var seasons = Manager.shared.seasons
    var season: String = ""
    var id: Int16 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create your Outfit"
        let doneOutfit = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createOutfit))
        navigationItem.rightBarButtonItem = doneOutfit
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tableSeason.isHidden = true
        addSeason.layer.cornerRadius = 5
        note.layer.cornerRadius = 5
        
        //desig images
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionOutfits.collectionViewLayout = layout
    

    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            self.collectionOutfits.reloadData()
        }
    }
    
    // MARK: - Private Method
    
    @objc func createOutfit()  {
        let rating = ratingControl.rating
        
        if season == "for what season of the year?" || rating == 0 || clothes.count == 0 || note.text == ""{
            let alert = UIAlertController(title: "Error fields", message: "The fields are empty!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let outfit1 = Outfit.insertNewOutfit(name: season, note: note.text, rating: Int16(rating))
            if clothes.count != 0 {
                for c in clothes {
                    Outfit.saveRelationship(clothe: c, outfit: outfit1!)
                    Clothe.saveRelationship(clothe: c, outfit: outfit1!)
                }
            }
            showToast(message: "OK, Add Outfit!!")
            cleanFields()
        }
    }

    //back images from ClothesCollectionViewController
    @IBAction func unwindFromClothesCollection(_ sender: UIStoryboardSegue)  {
       
    }
    
    
    @IBAction func addSeason(_ sender: UIButton) {
        if tableSeason.isHidden {
            animate(toogle: true, tableView: tableSeason)
        }else{
            animate(toogle: false, tableView: tableSeason)
        }
    }
    
    func animate(toogle: Bool, tableView: UITableView)  {
        if toogle {
            UIView.animate(withDuration: 0.3) {
            self.tableSeason.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3) {
            self.tableSeason.isHidden = true
              
            }
        }
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func cleanFields()  {
        addSeason.setTitle("for what season of the year?", for: .normal)
        ratingControl.rating = 0
        note.text = ""
        clothes = []
        DispatchQueue.main.async{
            self.collectionOutfits.reloadData()
        }
    }    
}



extension AddOutfitViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionOutfits.dequeueReusableCell(withReuseIdentifier: "cellOufit", for: indexPath) as! ImagesCategCollectionViewCell
        
        let clothe = clothes[indexPath.row]
        
        let image = Data(referencing: clothe.image!)
        cell.imageAddOutfit.image = UIImage(data: image as Data)

        return cell
    }
}


extension AddOutfitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableSeason.dequeueReusableCell(withIdentifier: "cellCateg", for: indexPath)
            cell.textLabel?.text = seasons[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            season = seasons[indexPath.row]
            addSeason.setTitle("\(seasons[indexPath.row])", for: .normal)
            animate(toogle: false,tableView: tableSeason)
        
    }
}
