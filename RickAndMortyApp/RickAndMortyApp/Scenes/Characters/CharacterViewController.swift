//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import UIKit
import SnapKit

protocol CharactersDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel)
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel)
}

class CharactersViewController: UIViewController {
    
    // MARK: - Objects
    
    private struct Constants {
        static let tableViewCornerRadius: CGFloat = 20.0
        static let tableViewRowHeight: CGFloat = 80.0
        static let requestPage: Int = 1
        static let customTableViewInset = 20.0
        static let customErrorMessage: String = "Error"
    }
    
    // MARK: - Properties
    
    private var interactor: CharacterModelsBusinessLogic?
    private var characters: [CharacterModels.DisplayCharacters.ViewModel.CharacterModel] = []
    
    private var charactersCount: Int = .zero {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.layer.masksToBounds = true
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = Constants.tableViewRowHeight
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.fetchCharacters()
    }
    
    // MARK: - Methods

    private func setup() {
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.tableView)
        
        let viewController = self
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter()
        let worker = CharactersNetworkWorker()
        let storageWorker = CharactersStorageWorker()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.networkWorker = worker
        interactor.storage = storageWorker
        presenter.viewController = viewController

        self.tableView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().inset(Constants.customTableViewInset)
            $0.right.equalToSuperview().inset(Constants.customTableViewInset)
            $0.bottom.equalToSuperview().inset(Constants.customTableViewInset)
            
        })
        self.tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseID)
    }
    
    private func fetchCharacters() {
        let request = CharacterModels.DisplayCharacters.Request(page: Constants.requestPage)
        self.interactor?.fetchCharacters(request: request)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - CharactersDisplayLogic
    
    func displayCharacters(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        self.charactersCount = viewModel.characterModels.count
        self.characters = viewModel.characterModels
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        let error = viewModel.errorMessage ?? Constants.customErrorMessage
        self.showErrorAlert(message: error)
    }
    
}


extension CharactersViewController: CharactersDisplayLogic {
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseID, for: indexPath) as? CharacterCell else {
            return UITableViewCell() }
        let character = self.characters[indexPath.row]
        cell.setupContent(photoURL: character.image, name: character.name, id: character.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
    

