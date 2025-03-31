//
//  CharacterEntity+CoreDataProperties.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 31.03.2025.
//
    
import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var iconURL: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var type: String?
    @NSManaged public var gender: String?

}

extension CharacterEntity : Identifiable {}
