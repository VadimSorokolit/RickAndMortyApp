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

class CharactersViewController: UIViewController, CharactersDisplayLogic {
    
    // MARK: - Objects
    
    private struct Constants {
        static let tableViewCornerRadius: CGFloat = 20.0
        static let tableViewRowHeight: CGFloat = 80.0
        static let requestPage: Int = 1
        static let customTableViewInset = 20.0
        static let titelLabelTopInset: CGFloat = 20.0
        static let tableViewTopInset: CGFloat = 30.0
        static let customErrorMessage: String = "Error"
        static let titleLabelFontSize: CGFloat = 30
    }
    
    // MARK: - Properties
    
    private var interactor: CharacterModelsBusinessLogic?
    private var characters: [CharacterModels.DisplayCharacters.ViewModel.CharacterModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = Constants.tableViewCornerRadius
        tableView.layer.masksToBounds = true
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = Constants.tableViewRowHeight
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseID)
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
        self.view.addSubview(self.titleLabel)
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
        
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(Constants.titelLabelTopInset)
            $0.centerX.equalToSuperview()
        })
        self.tableView.snp.makeConstraints({
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Constants.tableViewTopInset)
            $0.left.equalToSuperview().inset(Constants.customTableViewInset)
            $0.right.equalToSuperview().inset(Constants.customTableViewInset)
            $0.bottom.equalToSuperview().inset(Constants.customTableViewInset)
            
        })
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
        self.characters = viewModel.characterModels
    }
    
    func displayError(viewModel: CharacterModels.DisplayCharacters.ViewModel) {
        let error = viewModel.errorMessage ?? Constants.customErrorMessage
        self.showErrorAlert(message: error)
    }
    
}


// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseID, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell() }
        let character = self.characters[indexPath.row]
        cell.setupContent(photoURL: character.image, name: character.name, id: character.id)
        return cell
    }
    
}
    

