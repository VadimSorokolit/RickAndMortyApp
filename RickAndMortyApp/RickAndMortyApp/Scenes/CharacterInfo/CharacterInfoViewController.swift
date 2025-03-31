//
//  CharacterInfoViewController.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 31.03.2025.
//
    

import UIKit
import SnapKit

class CharacterInfoViewController: UIViewController {
    
    // MARK: - Objests
    
    private struct Constants {
        static let titleLabelFontSize: CGFloat = 30.0
        static let titelLabelTopInset: CGFloat = 20.0
        static let stackViewSpacing: CGFloat = 10.0
        static let labelsFontSize: CGFloat = 18.0
        static let placeholderImageName: String = "placeholder"
    }
    
    // MARK: - Properties
    
    var character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel?
    var interactor: CharacterInfoInteractor?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Character Info"
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelsFontSize, weight: .medium)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelsFontSize, weight: .medium)
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelsFontSize, weight: .medium)
        return label
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelsFontSize, weight: .medium)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.labelsFontSize, weight: .medium)
        return label
    }()

    // MARK: - Lifecycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.photoImageView)
        self.view.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(nameLabel)
        self.stackView.addArrangedSubview(idLabel)
        self.stackView.addArrangedSubview(genderLabel)
        self.stackView.addArrangedSubview(speciesLabel)
        self.stackView.addArrangedSubview(typeLabel)
        
        let viewController = self
        let interactor = CharacterInfoInteractor()
        let presenter = CharacterInfoPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(Constants.titelLabelTopInset)
            $0.centerX.equalToSuperview()
        })
        
        self.photoImageView.snp.makeConstraints({
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Constants.titelLabelTopInset)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(Constants.titelLabelTopInset)
            $0.right.equalToSuperview().inset(Constants.titelLabelTopInset)
            $0.size.equalTo(UIScreen.main.bounds.width)
        })
        
        self.stackView.snp.makeConstraints({
            $0.top.equalTo(self.photoImageView.snp.bottom).offset(Constants.titelLabelTopInset)
            $0.left.equalToSuperview().offset(Constants.titelLabelTopInset)
        })
        
        if self.character != nil {
             self.updateUI()
         }
    }
    
    private func updateUI() {
        guard let character = self.character else { return }
        self.nameLabel.text = "Name: \(character.name)"
        self.idLabel.text = "ID: \(character.id)"
        self.genderLabel.text = "Gender: \(character.gender)"
        self.speciesLabel.text = "Species: \(character.species)"
        self.typeLabel.text = "Type: \(character.type)"
        
        if let url = URL(string: character.image), !character.image.isEmpty {
            self.photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.placeholderImageName))
        } else {
            self.photoImageView.image = UIImage(named: Constants.placeholderImageName)
        }
    }
    
}
