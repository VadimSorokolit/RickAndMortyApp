//
//  CharactersInteractor.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import Foundation

protocol CharacterModelsBusinessLogic: AnyObject {
    func fetchCharacters(request: CharacterModels.DisplayCharacters.Request)
}

class CharactersInteractor: CharacterModelsBusinessLogic {
    
    // MARK: - Properties
    
    var networkWorker: CharactersNetworkWorkerProtocol?
    var storage: CharactersStorageProtocol?
    var presenter: CharactersPresenterLogic?
    
    // MARK: - Methods
    
    func fetchCharacters(request: CharacterModels.DisplayCharacters.Request) {
        self.networkWorker?.fetchCharacters(page: request.page) { [weak self] result in
            switch result {
                case .success(let characters):
                    self?.storage?.saveCharacters(characters: characters.results, completion: nil)
                    
                    let response = CharacterModels.DisplayCharacters.Response(characters: characters.results)
                    self?.presenter?.presentCharacters(response: response)
                    
                case .failure(let networkError):
                    self?.storage?.fetchCharacters { localResult in
                        switch localResult {
                            case .success(let cachedCharacters) where !cachedCharacters.isEmpty:
                                let charResults = cachedCharacters.map { entity in
                                    CharResult(id: Int(entity.id),
                                               name: entity.name ?? "Unknown",
                                               image: entity.iconURL ?? "",
                                               species: entity.species ?? "",
                                               gender: entity.gender ?? "",
                                               type: entity.type ?? "")
                                }
                                let response = CharacterModels.DisplayCharacters.Response(characters: charResults)
                                self?.presenter?.presentCharacters(response: response)
                            case .success, .failure:
                                self?.presenter?.presentError(error: networkError)
                        }
                    }
            }
        }
    }
    
}
