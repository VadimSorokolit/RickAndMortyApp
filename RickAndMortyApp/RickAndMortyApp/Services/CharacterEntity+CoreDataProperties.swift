//
//  CharacterEntity+CoreDataProperties.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 29.03.2025.
//
    

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var iconURL: String?
    @NSManaged public var name: String?

}

extension CharacterEntity : Identifiable {}
