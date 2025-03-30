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
    var interactor: CharacterModelsBusinessLogic?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .yellow
        
// TODO: - For tests !!!
        self.setup()
        self.fetchCharacters()
    }
    
    // MARK: - Methods

// TODO: - For tests !!!
    private func setup() {
        let viewController = self
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter()
        let coreDataManager = CoreDataManager()
        let worker = CharactersWorker(coreDataManager: coreDataManager)

        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
    }
    
    func fetchCharacters() {
        let request = CharacterModels.DisplayCharacters.Request(page: 1)
        self.interactor?.fetchCharacters(request: request)
    }
    
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print(viewModel.characterInformation)
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        print(viewModel.errorMessage ?? "Error")
    }
    
}

