//
//  CoreDataManager.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 29.03.2025.
//


import Foundation
import CoreData

protocol APICharacters: AnyObject {
    func fetchCharacters(completion: @escaping (Result<[CharacterEntity], Error>) -> Void)
}

class CoreDataManager: APICharacters {
    
    // MARK: - Properties
    
    private var persistentContainer: NSPersistentContainer!
    
    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK: - Initializer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    // MARK: - Methods
    
    func fetchCharacters(completion: @escaping (Result<[CharacterEntity], any Error>) -> Void) {
        self.persistentContainer.performBackgroundTask({ (context: NSManagedObjectContext) -> Void in
            let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            do {
                let characters = try context.fetch(fetchRequest)
                completion(.success(characters))
            } catch {
                completion(.failure(error))
            }
            
        })
    }
    
    func saveCharacters(characters: [CharResult], completion: ((Error?) -> Void)? = nil) {
        persistentContainer.performBackgroundTask { context in
            for apiCharacter in characters {
                let characterEntity = CharacterEntity(context: context)
                characterEntity.id = Int64(apiCharacter.id) 
                characterEntity.name = apiCharacter.name
                characterEntity.image = apiCharacter.image
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
    

