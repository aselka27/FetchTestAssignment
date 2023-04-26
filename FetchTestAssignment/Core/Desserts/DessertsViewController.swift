//
//  ViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertsViewController: UIViewController {
    
    
    private lazy var dessertsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 60, right: 0)
        layout.minimumInteritemSpacing = 12
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DessertCollectionViewCell.self, forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier, for: indexPath) as? DessertCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertsCollectionView.frame.size
        return CGSize(width: size.width-40, height: 214)
    }
}
