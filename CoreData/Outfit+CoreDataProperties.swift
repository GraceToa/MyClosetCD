//
//  Outfit+CoreDataProperties.swift
//  MyCloset
//
//  Created by GraceToa on 18/08/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var rating: Int16
    @NSManaged public var clothes: Set<Clothe>?

}

// MARK: Generated accessors for clothes
extension Outfit {

    @objc(addClothesObject:)
    @NSManaged public func addToClothes(_ value: Clothe)

    @objc(removeClothesObject:)
    @NSManaged public func removeFromClothes(_ value: Clothe)

    @objc(addClothes:)
    @NSManaged public func addToClothes(_ values: NSSet)

    @objc(removeClothes:)
    @NSManaged public func removeFromClothes(_ values: NSSet)
    
    
    static func insertNewOutfit (name: String, note: String, rating: Int16) -> Outfit?   {
        var id: Int16
        let outfit = NSEntityDescription.insertNewObject(forEntityName: "Outfit" , into: AppDelegate.managedObjectContext!) as! Outfit
        
        let fetchResult: NSFetchRequest<Outfit> = Outfit.fetchRequest()
        let orderById = NSSortDescriptor(key: "id", ascending: false)
        fetchResult.sortDescriptors = [orderById]
        fetchResult.fetchLimit = 1
        let moc = AppDelegate.managedObjectContext

        do {
            let idResult =  try moc!.fetch(fetchResult)
            id = idResult[0].id + 1
            outfit.id = id
        } catch let error as NSError {
            print("Error create id", error)
        }
        
        outfit.name = name
        outfit.note = note
        outfit.rating = rating
        
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cannot insert new outfit",nserror)
            return nil
        }
        print("Insert outfit with name: \(outfit.name ?? "")successful")
        return outfit
    }
    
    
    static func fetchOutfitWithFilter(nameContains: String?, nameExactly: String?) -> [Outfit] {
        var result = [Outfit]()
        let moc = AppDelegate.managedObjectContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Outfit.fetchRequest()
        var subPredicates = [NSPredicate]()
        
        if nameContains != nil {
            //let predicate1 = NSPredicate(format: "name contains[cd] %@", nameContains!)//cd= case an diacritic insensitive lookups
            let predicate1 = NSPredicate(format: "name contains %@", nameContains!)//no sensitive
            subPredicates.append(predicate1)
        }
        
        if nameExactly != nil {
            let predicate2 = NSPredicate(format: "name == %@", nameExactly!)
            subPredicates.append(predicate2)
        }
        
        if subPredicates.count > 0 {
            let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
            fetchRequest.predicate = compoundPredicates
        }
        do {
            result = try moc!.fetch(fetchRequest) as! [Outfit]
        } catch  {
            print("Cannot fetch outfits. Error \(error)")
            return result
        }
        return result
    }
    
    static func getAllOutfits() -> [Outfit] {
        var result = [Outfit]()
        let moc = AppDelegate.managedObjectContext
        do {
            result = try moc!.fetch(Outfit.fetchRequest()) as! [Outfit]
        } catch  {
            print("Cannot fetch outfits. error \(error)")
            return result
        }
        return result
    }
    
    static func saveRelationship(clothe: Clothe, outfit: Outfit)  {
        outfit.clothes?.insert(clothe)
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cannot insert clothes in outfit",nserror)
        }
    }
   
    static func deleteOutfit(outfit: Outfit){
        let moc = AppDelegate.managedObjectContext
        moc?.delete(outfit)
        do {
            try AppDelegate.managedObjectContext?.save()
            print("Delete Outfit succesful.")
        } catch  {
            let nserror = error as NSError
            print("Delete Outfit unsuccesful. Error is: \(nserror),\(nserror.userInfo)")
        }
    }
    
    static func deleteAllOutfits(){
        let moc = AppDelegate.managedObjectContext
        let outfits = Outfit.getAllOutfits()
        for o in outfits {
            moc?.delete(o)
        }
        do {
            try AppDelegate.managedObjectContext?.save()
            print("Delete all outfits succesful.")
        } catch  {
            let nserror = error as NSError
            print("Delete all outfits unsuccesful. Error is: \(nserror),\(nserror.userInfo)")
        }
    }
    
    
    func toString()  {
        print("Outfit 's details: Name = \(name ?? ""), note = \(note ?? "")")
        if let clothesList = clothes {
            if clothesList.count == 0 {
                return
            }
            print("Outfit 's clothes details: ")
            for eachClothes in clothesList {
                (eachClothes).toString()
            }
        }
    }

}
