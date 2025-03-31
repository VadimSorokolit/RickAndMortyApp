//
//  CharactersPresenter.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import Foundation

protocol CharactersPresenterLogic: AnyObject {
    func presentCharacters(response: CharacterModels.DisplayCharacters.Response)
    func presentError(error: Error)
}

class CharactersPresenter: CharactersPresenterLogic {
    
    // MARK: - Properties
    
    weak var viewController: CharactersDisplayLogic?
    
    // MARK: - Methods
    
    func presentCharacters(response: CharacterModels.DisplayCharacters.Response) {
        let characters = response.characters.map({ character in
            CharacterModels.DisplayCharacters.ViewModel.CharacterModel(character: character)
        })
        let viewModel = CharacterModels.DisplayCharacters.ViewModel(characterModels: characters)
        self.viewController?.displayCharacters(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        let errorMessage = error.localizedDescription
        
        let errorViewModel = CharacterModels.DisplayCharacters.ViewModel(errorMessage: errorMessage)
        self.viewController?.displayError(viewModel: errorViewModel)
    }
    
}
