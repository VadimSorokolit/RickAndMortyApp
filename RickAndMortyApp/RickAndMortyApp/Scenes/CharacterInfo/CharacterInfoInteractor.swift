//
//  CharacterInteractor.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 31.03.2025.
//
    

import Foundation

protocol CharacterInfoBusinessLogic: AnyObject  {
    func transferCharacterInfoToPresenter (character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel)
}

class CharacterInfoInteractor : CharacterInfoBusinessLogic {
    
    var character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel?
    var presenter: CharacterInfoPresenterLogic?
    
    // MARK: - Methods
    
    func transferCharacterInfoToPresenter (character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel) {
        self.character = character
        self.presenter?.displayCharacterInfo(character: character)
    }
    
}
    
