//
//  ListViewController.swift
//  MyCloset
//
//  Created by GraceToa on 28/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import UIKit

class ListClothesViewController: UIViewController {
    
    @IBOutlet weak var tableList: UITableView!
    
    var categories = List.elements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Closet"
        addNavBarBackground()
       
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Actions methods

    @IBAction func addClothes(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowAddEdit", sender: self)
    }
}


extension ListClothesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableList.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as! ListTableViewCell
        let c = categories[indexPath.row]
        cell.backgroundImage.image = c.image
        cell.nameList.text = c.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowImgCategories", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowImgCategories" {
            if let id = tableList.indexPathForSelectedRow {
               let categRow = categories[id.row]
                let destin = segue.destination as! ImagesCategCollectionViewController
                destin.category = categRow.name
            }
        }
    }
}

extension UIViewController {
    func addNavBarBackground()  {
        let navBar = navigationController?.navigationBar
        navBar?.setBackgroundImage(UIImage(), for: .compact)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = true
        navBar?.backgroundColor = .clear
        navBar?.setBackgroundImage(UIImage(named: "fondoNaviBarBlue")?.resizableImage(withCapInsets: UIEdgeInsets.zero), for: .default)
    }
}

