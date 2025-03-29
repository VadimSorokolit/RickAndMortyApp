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

// TODO: - For tests !!!
//    weak var interactor: CharacterModelsBusinessLogic?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
// TODO: - For tests !!!
//        self.setup()
//        self.fetchCharacters()
    }
    
    // MARK: - Methods

// TODO: - For tests !!!
//    private func setup() {
//        self.view.backgroundColor = .yellow
//        let viewController = self
//        let interactor = CharactersInteractor()
//        let presenter = CharactersPresenter()
//        
//        interactor.presenter = presenter
//        presenter.viewController = viewController
//        viewController.interactor = interactor
//    }
//    
//    func fetchCharacters() {
//        let request = CharacterModels.DisplayCharacters.Request(page: 0)
//        self.interactor?.fetchCharacters(request: request)
//    }
    
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print(viewModel.characterInformation)
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print(viewModel.errorMessage ?? "Error")
    }
    
}

