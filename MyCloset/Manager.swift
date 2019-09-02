//
//  ManagerHelper.swift
//  MyCloset
//
//  Created by GraceToa on 28/07/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//

import Foundation
import UIKit

class Manager {
    
    static let shared = Manager()
    var images: [Image] = []
    var categories = ["Dress","Glasses","Jackets","Handbags","Jeans","Jewelry","Shirt","T-shirt","Shoes","Sneakers","Stiletos","Pants"]
    var ocassion = ["Casual", "Formal","for Work","Gala"]
    var seasons = [ "Autumn","Spring","Summer","Winter"]

}


struct Category {
    var id: Int
    var name: String
    var image: UIImage?
}

struct List {
    static let elements = [
        Category(id: 1, name: "Accessories", image: UIImage(named: "accessories.png")),
        Category(id: 2,name: "Coat", image: UIImage(named: "coat.png")),
        Category(id: 3,name: "Dresses", image: UIImage(named: "dresses.png")),
        Category(id: 4,name: "Shoes", image: UIImage(named: "shoes.png")),
        Category(id: 5,name: "Tops", image: UIImage(named: "tops.png")),
        Category(id: 6,name: "Trousers", image: UIImage(named: "trousers.png"))
    ]
    
    
}
