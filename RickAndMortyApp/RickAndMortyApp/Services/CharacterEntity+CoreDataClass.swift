//
//  CharacterEntity+CoreDataClass.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 29.03.2025.
//
    

import Foundation
import CoreData

@objc(CharacterEntity)
public class CharacterEntity: NSManagedObject {}

extension CharacterEntity {
    func toCharResult() -> CharResult {
        return CharResult(
            id: Int(self.id),
            name: self.name ?? "Unknown",
            image: self.image ?? ""
        )
    }
}

