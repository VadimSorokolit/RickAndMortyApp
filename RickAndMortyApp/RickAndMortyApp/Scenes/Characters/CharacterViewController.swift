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

class CharactersViewController: UIViewController, CharactersDisplayLogic {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
    }
    // MARK: - Methods
    
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print("")
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print("")
    }
    
}

