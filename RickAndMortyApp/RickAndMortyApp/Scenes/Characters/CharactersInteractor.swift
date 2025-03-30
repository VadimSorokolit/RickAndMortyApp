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
    
    var worker: CharactersWorkerProtocol?
    var presenter: CharactersPresenterLogic?
    
    // MARK: - Methods
    
    func fetchCharacters(request: CharacterModels.DisplayCharacters.Request) {
        self.worker?.fetchCharacters(page: request.page, completion: { result in
            switch result {
                    case .success(let characters):
                    let response = CharacterModels.DisplayCharacters.Response(characters: characters.results)
                    self.presenter?.presentCharacters(response: response)
                case .failure(let error):
                    self.presenter?.presentError(error: error)
            }
        })
    }
    
}
