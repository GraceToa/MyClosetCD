//
//  ListAllViewController.swift
//  MyCloset
//
//  Created by GraceToa on 31/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ListAllViewController: UIViewController{
    
    @IBOutlet weak var tableListAll: UITableView!
    
    var clothes: [Clothe] = []
    var image: UIImage!
    var idImage: UUID!
    @objc var refreshcontrol: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Closet"
        let deleteAll = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(alertDeleteAll))
        navigationItem.rightBarButtonItem = deleteAll
        self.addNavBarBackground()
        refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(getter: refreshcontrol), for: UIControl.Event.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshcontrol.beginRefreshing()
        refreshClothes()
    }
    
    @objc func refreshClothes()  {
        clothes = Clothe.getAllClothes()
        tableListAll.reloadData()
    }
    
    // MARK: - Alert Actions

     @objc func alertDeleteAll()  {
        let alert = UIAlertController(title: "Do you want to delete all items?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            Clothe.deleteAllClothes()
            self.refreshClothes()
        }))
        present(alert, animated: true)
    }
}


extension ListAllViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableListAll.dequeueReusableCell(withIdentifier: "cellListAll", for: indexPath) as! ListAllTableViewCell
        let c = clothes[indexPath.row]
        cell.category.text = c.category
        cell.type.text = c.type
        cell.ratingControl.rating = Int(c.rating)
        let img = Data(referencing: c.image!)
        cell.imageListAll.image = UIImage(data: img)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let id = tableListAll.indexPathForSelectedRow {
                let rowClothe = clothes[id.row]
                let destin = segue.destination as! DetailClothesViewController
                destin.clothe = rowClothe
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteClothe = UITableViewRowAction(style: .destructive, title: "Delete") { (action,indexPath) in
            let clothe = self.clothes[indexPath.row]
            Clothe.deleteClothe(clothe: clothe)
            self.refreshClothes()
        }
        return [deleteClothe]
    }
}

