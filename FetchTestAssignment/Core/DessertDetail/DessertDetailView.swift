//
//  DessertDetailView.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit


final class DessertDetailView: UIView {
    
    //MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dessertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage.DessertsView.pizza
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dessertNameLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 17, fontWeight: .semibold, color: .gray)
        return label
    }()
    
    private lazy var categoryLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 13, fontWeight: .light)
        return label
    }()
    
    private lazy var dessertRegion: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 15, fontWeight: .regular)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var directionsLabel: CustomLabel = {
        let label = CustomLabel(frame: .zero, fontSize: 12, fontWeight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ingredientsTableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = false
        return tableView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setText()
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
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(dessertImageView, dessertNameLabel, infoStackView, segmentCollectionView, directionsLabel, ingredientsTableView)
        setupConstraints()
    }
    
    private func setText() {
        dessertRegion.text = "Origin: Malaysian"
        categoryLabel.text = "Dessert"
        dessertNameLabel.text = "Pressure Cooker Creme Brulee"
    }
    
     func configure(with model: MealDetail) {
        self.categoryLabel.text = model.strCategory
        self.dessertNameLabel.text = model.strMeal
        self.dessertRegion.text = model.strArea
        self.directionsLabel.text = model.strInstructions
        guard let imageURLString = model.strMealThumb else { return }
        if let imageURL = URL(string: imageURLString) {
            self.dessertImageView.load(url: imageURL, placeholder: UIImage(named: "placeholder"))
        }
       
    }
}

extension DessertDetailView {
    private func setupConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            dessertNameLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            dessertNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            dessertImageView.topAnchor.constraint(equalTo: dessertNameLabel.bottomAnchor, constant: 10),
            dessertImageView.widthAnchor.constraint(equalToConstant: 100),
            dessertImageView.heightAnchor.constraint(equalToConstant: 100),
            dessertImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
           
            infoStackView.centerYAnchor.constraint(equalTo: dessertImageView.centerYAnchor, constant: dessertImageView.frame.height/2),
            infoStackView.leadingAnchor.constraint(equalTo: dessertImageView.trailingAnchor, constant: 8),
            
            segmentCollectionView.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 30),
            segmentCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            segmentCollectionView.heightAnchor.constraint(equalToConstant: 30),
           
            directionsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            directionsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            directionsLabel.topAnchor.constraint(equalTo: segmentCollectionView.bottomAnchor, constant: 15),
            directionsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            
            ingredientsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            ingredientsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            ingredientsTableView.topAnchor.constraint(equalTo: segmentCollectionView.bottomAnchor, constant: 15),
            ingredientsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
