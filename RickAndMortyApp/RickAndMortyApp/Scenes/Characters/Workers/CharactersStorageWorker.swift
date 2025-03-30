//
//  CharactersStorageWorker.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 29.03.2025.
//


import Foundation
import CoreData

protocol CharactersStorageProtocol: AnyObject {
    func fetchCharacters(completion: @escaping (Result<[CharacterEntity], Error>) -> Void)
    func saveCharacters(characters: [CharResult], completion: ((Error?) -> Void)?)
}

class CharactersStorageWorker: CharactersStorageProtocol {
    
    // MARK: - Properties
    
    private let persistentContainer: NSPersistentContainer
    
    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK: - Initializer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "RickAndMortyApp")
        self.persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
    }
    
    // MARK: - Methods
    
    func fetchCharacters(completion: @escaping (Result<[CharacterEntity], Error>) -> Void) {
        self.persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            do {
                let characters = try context.fetch(fetchRequest)
                completion(.success(characters))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func saveCharacters(characters: [CharResult], completion: ((Error?) -> Void)? = nil) {
        self.persistentContainer.performBackgroundTask { context in
            for character in characters {
                let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", character.id)
                
                // Cheking is entity exists
                let existing = try? context.fetch(fetchRequest)
                
                if let existing = existing, !existing.isEmpty {
                    continue
                }
                
                let entity = CharacterEntity(context: context)
                entity.id = Int64(character.id)
                entity.name = character.name
                entity.iconURL = character.image
            }
            
            do {
                try context.save()
                completion?(nil)
            } catch {
                context.rollback()
                completion?(error)
            }
        }
    }
    
}
    

