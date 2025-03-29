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
    
    func presentCharacters(response: CharacterModels.DisplayCharacters.Response) {
        let cartoonCharacters = response.characters
    }
    
    func presentError(error: Error) {
        let errorMessage = error.localizedDescription
        
        let errorViewModel = CharacterModels.DisplayCharacters.ViewModel(characterInformation: [], errorMessage: errorMessage)
    }
    
}
