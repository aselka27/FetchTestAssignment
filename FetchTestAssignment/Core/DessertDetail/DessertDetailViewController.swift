//
//  DessertDetailViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    //MARK: Properties
    private let dessertView = DessertDetailView()
    private let viewModel: DessertDetailViewViewModel
    
    //MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: Init
    init(viewModel: DessertDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let indexPath = IndexPath(row: 0, section: 0)
        dessertView.segmentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        
        viewModel.fetch { [weak self] in
            DispatchQueue.main.async {
                guard let dessertDetail = self?.viewModel.dessertDetail else { return }
                self?.dessertView.configure(with: dessertDetail)
                self?.dessertView.ingredientsTableView.reloadData()
            }
        }
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(dessertView)
        dessertView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        setDelegates()
    }
    
    private func setDelegates() {
        dessertView.segmentCollectionView.delegate = self
        dessertView.segmentCollectionView.dataSource = self
        dessertView.ingredientsTableView.delegate = self
        dessertView.ingredientsTableView.dataSource = self
    }
    
    private func setupConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dessertView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            dessertView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            dessertView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            dessertView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dessertView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

   //MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension DessertDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as? SegmentCollectionViewCell else { return UICollectionViewCell() }
        let types = ["Ingredients", "Directions"]
        cell.configure(segmentType: types[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertView.segmentCollectionView.frame.size
        return CGSize(width: size.width/2-4, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dessertView.directionsLabel.isHidden = indexPath.item == 0 ? true : false
        self.dessertView.ingredientsTableView.isHidden = indexPath.item == 0 ? false : true
    }
}

  //MARK: UITableViewDataSource & UITableViewDelegate
extension DessertDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier, for: indexPath) as? IngredientTableViewCell else { return UITableViewCell() }
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.configure(with: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
