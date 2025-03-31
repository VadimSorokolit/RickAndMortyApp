//
//  CharacterInfoViewController.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 31.03.2025.
//
    

import UIKit

class CharacterInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel?
    var interactor: CharacterInfoInteractor?
    
    // MARK: - Lifecycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .yellow
        let viewController = self
        let interactor = CharacterInfoInteractor()
        let presenter = CharacterInfoPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
}
