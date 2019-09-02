//
//  Image+CoreDataProperties.swift
//  MyCloset
//
//  Created by GraceToa on 18/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var idUUID: UUID?
    @NSManaged public var image: NSData?
    
    
}
