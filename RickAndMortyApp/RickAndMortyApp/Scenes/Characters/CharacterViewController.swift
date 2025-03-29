//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import UIKit

protocol CharactersDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel)
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel)
}

class CharactersViewController: CharactersDisplayLogic {
    
    // MARK: - Methods
    
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        <#code#>
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        <#code#>
    }
    
}

