//
//  CharactersRouter.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

protocol CharactersRoutingLogic {
    func goToCharacterInfoViewController(_ character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel)
}

class CharactersRouter: CharactersRoutingLogic {
    
    // MARK: - Properties
    weak var vc: CharactersViewController?
    
    // MARK: - Methods
    
    func goToCharacterInfoViewController(_ character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel) {
        let characterInfoViewController = CharacterInfoViewController()
        
        let characterInteractor = CharacterInfoInteractor()
        let characterPresenter = CharacterInfoPresenter()
        
        characterInfoViewController.interactor = characterInteractor
        characterInteractor.presenter = characterPresenter
        characterPresenter.viewController = characterInfoViewController
        
        characterInteractor.transferCharacterInfoToPresenter(character: character)
        
        self.vc?.navigationController?.pushViewController(characterInfoViewController, animated: true)
    }
    
}
