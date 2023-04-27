//
//  CollectionViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = "DessertCollectionViewCell"
    private var isFavorite: Bool = false
    
    //MARK: Views
    private lazy var dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dessertNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage(systemName: "heart")?.withTintColor(.brown).withRenderingMode(.alwaysOriginal)
        button.setImage(heartImage?.withTintColor(.red).withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        favoriteButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    override func layoutSubviews() {
        super.layoutSubviews()
        dessertImageView.addCornerRadius(12)
        contentView.addCornerRadius(12)
        addShadow()
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(dessertImageView, dessertNameLabel, favoriteButton)
        setConstraints()
    }
   
   @objc private func favButtonTapped() {
       isFavorite.toggle()
       let checkMarkImage = isFavorite ? UIImage(systemName: "heart.fill")?.withTintColor(.red).withRenderingMode(.alwaysOriginal) : UIImage(systemName: "heart")?.withTintColor(.red).withRenderingMode(.alwaysOriginal)
       favoriteButton.setImage(checkMarkImage?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
    }
    
    //MARK: ConfigureCell
    func configure(with model: Meals) {
        self.dessertNameLabel.text = model.strMeal
        guard let imageURLString = model.strMealThumb else { return }
        if let imageURL = URL(string: imageURLString) {
            self.dessertImageView.load(url: imageURL, placeholder: UIImage(named: "placeholder"))
        }
    }
}


extension DessertCollectionViewCell {
    private func setConstraints() {
        let constraints = [
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dessertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dessertImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dessertImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.7),
            
            dessertNameLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 8),
            dessertNameLabel.leadingAnchor.constraint(equalTo: dessertImageView.leadingAnchor),
            dessertNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            
            favoriteButton.centerYAnchor.constraint(equalTo: dessertNameLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addShadow() {
           contentView.layer.masksToBounds = false
           contentView.layer.shadowColor = UIColor.black.cgColor
           contentView.layer.shadowOpacity = 0.15
           contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
           contentView.layer.shadowRadius = 3.0
       }
}
