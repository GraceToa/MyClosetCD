//
//  Clothe+CoreDataProperties.swift
//  MyCloset
//
//  Created by GraceToa on 01/09/2019.
//  Copyright © 2019 GraceToa. All rights reserved.
//
//

import Foundation
import CoreData


extension Clothe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothe> {
        return NSFetchRequest<Clothe>(entityName: "Clothe")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int16
    @NSManaged public var ocassion: String?
    @NSManaged public var rating: Int16
    @NSManaged public var season: String?
    @NSManaged public var type: String?
    @NSManaged public var outfit: Set<Outfit>?
    

}

// MARK: Generated accessors for outfit
extension Clothe {

    @objc(addOutfitObject:)
    @NSManaged public func addToOutfit(_ value: Outfit)

    @objc(removeOutfitObject:)
    @NSManaged public func removeFromOutfit(_ value: Outfit)

    @objc(addOutfit:)
    @NSManaged public func addToOutfit(_ values: NSSet)

    @objc(removeOutfit:)
    @NSManaged public func removeFromOutfit(_ values: NSSet)
    
    static func insertNewClothe(image: NSData, category: String, ocassion: String, rating: Int16,season: String, type: String)  {
        let clothe = NSEntityDescription.insertNewObject(forEntityName: "Clothe" , into: AppDelegate.managedObjectContext!) as! Clothe
        var id: Int16
        
        clothe.category = category
        clothe.ocassion = ocassion
        clothe.rating = rating
        clothe.season = season
        clothe.type = type
        
        //SELECT * FROM Clothes ORDER BY id desc LIMIT 1
        let fetchResult: NSFetchRequest<Clothe> = Clothe.fetchRequest()
        let orderById = NSSortDescriptor(key: "id", ascending: false)
        fetchResult.sortDescriptors = [orderById]
        fetchResult.fetchLimit = 1
        let moc = AppDelegate.managedObjectContext
        
        do {
            let idResult =  try moc!.fetch(fetchResult)
            id = idResult[0].id + 1
            clothe.id = id
        } catch let error as NSError {
            print("Error  id in Clothe", error)
        }
        
        let uuid = UUID()
        clothe.idUUID = uuid
        clothe.image = image
        
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cannot insert new clothe",nserror)
        }
        print("Insert clothe: \(clothe.type ?? "") successful")
    }
    
    static func getAllClothes() -> [Clothe] {
        var result = [Clothe]()
        let moc = AppDelegate.managedObjectContext
        do {
            result = try moc!.fetch(Clothe.fetchRequest()) as! [Clothe]
        } catch  {
            print("Cannot fetch clothes .Error\(error)")
            return result
        }
        return result
    }
    
    static func getAllClothesForCategory(category: String) -> [Clothe] {
        var result = [Clothe]()
        let moc = AppDelegate.managedObjectContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Clothe.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "category =%@", category)
        do {
            result = try moc!.fetch(fetchRequest) as! [Clothe]
        } catch  {
            print("Cannot fetch category Clothes \(error)")
            return result
        }
        return result
    }
    
    
    static func saveRelationship(clothe: Clothe, outfit: Outfit)  {
        clothe.outfit?.insert(outfit)
        do {
            try AppDelegate.managedObjectContext?.save()
        } catch {
            let nserror = error as NSError
            print("Cannot insert outfit in clothe",nserror)
        }
    }
    
    static func deleteClothe(clothe: Clothe) {
        let moc = AppDelegate.managedObjectContext
        moc?.delete(clothe)
        do {
            try AppDelegate.managedObjectContext?.save()
            moc?.processPendingChanges()
            print("Delete clothe succesful.")
        } catch  {
            let nserror = error as NSError
            print("Delete clothe unsuccesful. Error is: \(nserror),\(nserror.userInfo)")
        }
    }
    
    static func deleteAllClothes() {
        let moc = AppDelegate.managedObjectContext
        let clothes = Clothe.getAllClothes()
        
        for clothe in clothes {
            moc?.delete(clothe)
        }
        do {
            try AppDelegate.managedObjectContext?.save()
            print("Delete all clothes succesful.")
        } catch  {
            let nserror = error as NSError
            print("Delete all clothes unsuccesful. Error is: \(nserror),\(nserror.userInfo)")
        }
    }
    
    
    
    //this function is used for showing object's details
    func toString()  {
        print("Clothes details: Image= \(String(describing: idUUID) ), Category = \(category ?? ""), Ocassion: \(ocassion ?? ""), For Season: \(season == "")")
    }

}
