//
//  CartoonCharacterCell.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 30.03.2025.
//
    

import Foundation
import UIKit
import SnapKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - Objects
    
    private struct Constants {
        static let imageViewSize: CGFloat = 50.0
        static let fatalErrorMessage: String = "init(coder:) has not been implemented"
        static let photoImageViewLeftInset: CGFloat = 20.0
        static let nameLabelInsets : UIEdgeInsets = UIEdgeInsets(top: 15.0, left: 30.0, bottom: 0.0, right: 10.0)
        static let idLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 30.0, bottom: 0.0, right: 0.0)
    }
    
    // MARK: - Properties
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.imageViewSize / 2.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorMessage)
    }
    
    // MARK: Methods
    
    private func setupSubviews() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.photoImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.idLabel)
    }
    
    private func setupConstraints() {
        self.photoImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(Constants.photoImageViewLeftInset)
            $0.size.equalTo(Constants.imageViewSize)
        })
        
        self.nameLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Constants.nameLabelInsets.top)
            $0.left.equalTo(self.photoImageView.snp.right).offset(Constants.nameLabelInsets.left)
            $0.right.equalToSuperview().inset(Constants.nameLabelInsets.right)
        })
        
        self.idLabel.snp.makeConstraints({
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(Constants.idLabelInsets.top)
            $0.left.equalTo(self.photoImageView.snp.right).offset(Constants.idLabelInsets.left)
        })
    }
    
    func setupContent(character: CharacterModels.DisplayCharacters.ViewModel.CharacterModel) {
        let imageUrl = URL(string: character.image)
        let placeholderImage = UIImage(named: "placeholder")
        self.photoImageView.sd_setImage(with: imageUrl, placeholderImage: placeholderImage)
        self.nameLabel.text = character.name
        self.idLabel.text = "ID: \(character.id)"
    }
    
}
