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
        static let defaultTopInset: CGFloat = 20.0
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Lifecycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.photoImageView)
        self.contentView.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.idLabel)
        self.stackView.addArrangedSubview(self.genderLabel)
        self.stackView.addArrangedSubview(self.speciesLabel)
        self.stackView.addArrangedSubview(self.typeLabel)
        
        let interactor = CharacterInfoInteractor()
        let presenter = CharacterInfoPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
        
        self.scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        self.contentView.snp.makeConstraints({
            $0.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        })
        
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalTo(contentView)
        })
        
        self.photoImageView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.defaultTopInset)
            $0.centerX.equalTo(contentView)
            $0.left.equalTo(contentView).offset(Constants.defaultTopInset)
            $0.right.equalTo(contentView).inset(Constants.defaultTopInset)
            $0.height.equalTo(photoImageView.snp.width)
        })
        
        self.stackView.snp.makeConstraints({
            $0.top.equalTo(photoImageView.snp.bottom).offset(Constants.defaultTopInset * 2.0)
            $0.left.equalTo(contentView).offset(Constants.defaultTopInset)
            $0.right.equalTo(contentView).inset(Constants.defaultTopInset)
            $0.bottom.equalTo(contentView).inset(Constants.defaultTopInset)
        })
        
        self.updateUI()
    }
    
    private func updateUI() {
        guard let character = self.character else { return }
        self.nameLabel.text = "Name: \(character.name)"
        self.idLabel.text = "ID: \(character.id)"
        self.genderLabel.text = "Gender: \(character.gender)"
        self.speciesLabel.text = "Species: \(character.species)"
        let characterType = character.type.isEmpty ? "Unknown" : character.type
        self.typeLabel.text = "Type: \(characterType)"
        
        if let url = URL(string: character.image), !character.image.isEmpty {
            self.photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.placeholderImageName))
        } else {
            self.photoImageView.image = UIImage(named: Constants.placeholderImageName)
        }
    }
    
}

