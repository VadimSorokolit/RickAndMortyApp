//
//  CharacterPresenter.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 31.03.2025.
//
    

import Foundation

protocol CharacterInfoPresenterLogic: AnyObject {
    func displayCharacterInfo(character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel)
}

class CharacterInfoPresenter: CharacterInfoPresenterLogic {
    
    // MARK: - Properties
    
    var viewController: CharacterInfoViewController?
    
    // MARK: - Methods
    
    func displayCharacterInfo(character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel) {
        self.viewController?.character = character
    }
    
}
