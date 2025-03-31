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

class CartoonCharacterCell: UITableViewCell {
    
    // MARK: - Objects
    
    private struct Constants {
        static let imageViewSize: CGFloat = 50.0
        static let fatalErrorMessage: String = "init(coder:) has not been implemented"
        static let photoImageViewLeftInset: CGFloat = 20.0
        static let nameLabelInsets: (top: CGFloat, left: CGFloat, right: CGFloat) = (top: 15.0, left: 30.0, right: 10.0)
        static let idLabelInsets: (top: CGFloat, left: CGFloat) = (top: 5.0, left: 30.0)
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
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorMessage)
    }
    
    // MARK: Setup functions
    
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
    
    func setupContent(photoURL: String, name: String, id: Int) {
        self.photoImageView.sd_setImage(with: URL(string: photoURL), placeholderImage: UIImage(named: "placeholder"))
        self.nameLabel.text = name
        self.idLabel.text = "ID: \(id)"
    }
    
}
