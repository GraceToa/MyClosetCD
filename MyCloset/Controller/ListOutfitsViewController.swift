//
//  OutfitsViewController.swift
//  MyCloset
//
//  Created by GraceToa on 12/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ListOutfitsViewController: UIViewController {
    
    @IBOutlet weak var tableOutfit: UITableView!
    
    var outfits: [Outfit] = []
    var clothes: [Clothe] = []
    var images: [Image] = []
    @objc var refreshcontrol: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Outfits"
        self.addNavBarBackground()
        refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(getter: refreshcontrol), for: UIControl.Event.valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshcontrol.beginRefreshing()
        refreshOutfits()
    }
    
    @objc func refreshOutfits()  {
        outfits = Outfit.getAllOutfits()
        tableOutfit.reloadData()
    }

    // MARK: - Actions Methods

    @IBAction func addOutfit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowAddOutfit", sender: self)
    }
    
    
    @IBAction func deleteOutfits(_ sender: Any) {
        alertDeleteAll()
    }
    
    func alertDeleteAll()  {
        let alert = UIAlertController(title: "Do you want to delete all items?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            Outfit.deleteAllOutfits()
            self.refreshOutfits()
        }))
        present(alert, animated: true)
    }
}


extension ListOutfitsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOutfit.dequeueReusableCell(withIdentifier: "cellOutfit", for: indexPath) as! OutfitsTableViewCell
        let outfit = outfits[indexPath.row]
        cell.season.text = outfit.name
        cell.ratingControl.rating = Int(outfit.rating)
        cell.note.text = outfit.note
        
        var image: Data!
        for img in outfit.clothes! {
            let i = img.image
            image = Data(referencing: i!)
        }
        cell.imageOutfit.image = UIImage(data: image as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "ShowDetailOutfit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailOutfit" {
            if let id = tableOutfit.indexPathForSelectedRow {
                let outfitRow = outfits[id.row]
                let destin = segue.destination as! DetailOutfitViewController
                destin.outfit = outfitRow
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteOutfit = UITableViewRowAction(style: .destructive, title: "Delete") { (action,indexPath) in
            let outfit = self.outfits[indexPath.row]
            Outfit.deleteOutfit(outfit: outfit)
            self.refreshOutfits()
        }
        return [deleteOutfit]
    }
}
