//
//  CollectionViewCell.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

final class DessertCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = "DessertCollectionViewCell"
    private var heartIcon: UIImage = UIImage.FavoriteButton.emptyHeart
    private let configuration = UIImage.SymbolConfiguration(pointSize: 23)
    private lazy var isFavorite: Bool = false {
        didSet {
            heartIcon = isFavorite ? UIImage.FavoriteButton.heart.withConfiguration(configuration) : UIImage.FavoriteButton.emptyHeart.withConfiguration(configuration)
        }
    }
  
    
    //MARK: Views
    private lazy var dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage.DessertsView.pizza
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dessertNameLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 16, fontWeight: .semibold)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.FavoriteButton.emptyHeart.withConfiguration(configuration), for: .normal)
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
       favoriteButton.setImage(heartIcon, for: .normal)
    }
    
    //MARK: ConfigureCell
    func configure(with model: Meal) {
        self.dessertNameLabel.text = model.strMeal
        guard let imageURLString = model.strMealThumb else { return }
        if let imageURL = URL(string: imageURLString) {
            self.dessertImageView.load(url: imageURL, placeholder: UIImage.DessertsView.placeholderImage)
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
            dessertNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            favoriteButton.centerYAnchor.constraint(equalTo: dessertNameLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6)
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
