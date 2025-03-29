//
//  CharactersPresenter.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import UIKit

protocol CharactersPresenterLogic {
    func presentCharacters(response: CharacterModels.DisplayCharacters.Response)
    func presentError(error: Error)
}

class CharactersPresenter: CharactersPresenterLogic {
    
    // MARK: - Properties
    
    var viewController: CharactersDisplayLogic?
    
    // MARK: - Methods
    
    func presentCharacters(response: CharacterModels.DisplayCharacters.Response) {
        let viewModelCharacters = response.characters.map({ character in
            CharacterModels.DisplayCharacters.ViewModel.characterInformationModel(
                id: character.id,
                name: character.name,
                species: character.species
            )
        })
        let viewModel = CharacterModels.DisplayCharacters.ViewModel(characterInformation: viewModelCharacters)
        self.viewController?.displayCharacters(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        let errorMessage = error.localizedDescription
        
        let errorViewModel = CharacterModels.DisplayCharacters.ViewModel(characterInformation: [], errorMessage: errorMessage)
        self.viewController?.displayError(viewModel: errorViewModel)
    }
    
}
