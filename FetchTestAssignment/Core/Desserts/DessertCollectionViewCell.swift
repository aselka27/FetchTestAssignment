//
//  CollectionViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    private var isFavorite: Bool = false
    
    private lazy var dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pizza")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dessertName: UILabel = {
        let label = UILabel()
        label.text = "Pizza"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage(systemName: "heart")?.applyingSymbolConfiguration(.init(pointSize: 30, weight: .bold))
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        favoriteButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dessertImageView.addCornerRadius(12)
        contentView.addCornerRadius(12)
        addShadow()
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(dessertImageView, dessertName, favoriteButton)
      
        setConstraints()
    }
   
    private func setConstraints() {
        let constraints = [
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dessertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dessertImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dessertImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.7),
            
            dessertName.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 8),
            dessertName.leadingAnchor.constraint(equalTo: dessertImageView.leadingAnchor),
            
            favoriteButton.centerYAnchor.constraint(equalTo: dessertName.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
   @objc private func favButtonTapped() {
        isFavorite.toggle()
    }
}


extension DessertCollectionViewCell {
    private func addShadow() {
           contentView.layer.masksToBounds = false
           contentView.layer.shadowColor = UIColor.black.cgColor
           contentView.layer.shadowOpacity = 0.15
           contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
           contentView.layer.shadowRadius = 3.0
       }
}
