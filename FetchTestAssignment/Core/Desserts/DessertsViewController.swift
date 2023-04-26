//
//  ViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertsViewController: UIViewController {
    
    private let viewModel: DessertViewViewModelImpl
    
    private lazy var dessertsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 7, bottom: 60, right: 7)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DessertCollectionViewCell.self, forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: DessertViewViewModelImpl) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getDessert {
            DispatchQueue.main.async { [weak self] in
                self?.dessertsCollectionView.reloadData()
            }
        }
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(dessertsCollectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        let constraints = [
            dessertsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            dessertsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dessertsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dessertsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension DessertsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allDesserts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier, for: indexPath) as? DessertCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let dessert = viewModel.allDesserts?[indexPath.item] {
            cell.configure(with: dessert)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertsCollectionView.frame.size
        return CGSize(width: (size.width/2)-16, height: 214)
    }
}
