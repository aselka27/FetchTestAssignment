//
//  DessertDetailView.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit


class DessertDetailView: UIView {
    
    //MARK: Views
    private lazy var dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pizza")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dessertNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pressure Cooker Creme Brulee"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Dessert"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dessertRegion: UILabel = {
        let label = UILabel()
        label.text = "Origin: Malaysian"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dessertRegion, categoryLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var segmentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        return collectionView
    }()
    
    lazy var directionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ingredientsTableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        tableView.isHidden = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dessertImageView.addCornerRadius(12)
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        backgroundColor = .white
        addSubview(dessertImageView, dessertNameLabel, infoStackView, segmentCollectionView, directionsLabel, ingredientsTableView)
        setupConstraints()
    }
    
     func configure(with model: MealDetail) {
        self.categoryLabel.text = model.strCategory
        self.dessertNameLabel.text = model.strMeal
        self.dessertRegion.text = model.strArea
        guard let imageURLString = model.strMealThumb else { return }
        if let imageURL = URL(string: imageURLString) {
            self.dessertImageView.load(url: imageURL, placeholder: UIImage(named: "placeholder"))
        }
        directionsLabel.text = model.strInstructions
    }
}


extension DessertDetailView {
    private func setupConstraints() {
        let constraints = [
            dessertNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dessertNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dessertImageView.topAnchor.constraint(equalTo: dessertNameLabel.bottomAnchor, constant: 10),
            dessertImageView.widthAnchor.constraint(equalToConstant: 100),
            dessertImageView.heightAnchor.constraint(equalToConstant: 100),
            dessertImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            infoStackView.centerYAnchor.constraint(equalTo: dessertImageView.centerYAnchor, constant: dessertImageView.frame.height/2),
            infoStackView.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 8),
            segmentCollectionView.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 30),
            segmentCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentCollectionView.heightAnchor.constraint(equalToConstant: 30),
            directionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            directionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            directionsLabel.topAnchor.constraint(equalTo: segmentCollectionView.bottomAnchor, constant: 15),
            directionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            ingredientsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ingredientsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ingredientsTableView.topAnchor.constraint(equalTo: segmentCollectionView.bottomAnchor, constant: 15),
            ingredientsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
