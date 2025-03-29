//
//  CharactersInteractor.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import UIKit

protocol CharacterModelsBusinessLogic {
    func fetchCharacters(request: CharacterModels.DisplayCharacters.Request)
}

class CharactersInteractor: CharacterModelsBusinessLogic {
    
    // MARK: - Properties
    
    var worker: CharactersWorker?
    var presenter: CharactersPresenterLogic?
    
    // MARK: - Methods
    
    func fetchCharacters(request: CharacterModels.DisplayCharacters.Request) {
        worker?.fetchCharacters(page: 8, completion: { result in
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
