//
//  DessertsView.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit


final class DessertsView: UIView {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Views
     lazy var dessertsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 7, bottom: 60, right: 7)
//        collectionView.showsVerticalScrollIndicator = false
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: ConfigureUI
    private func configureUI() {
        backgroundColor = .white
        addSubview(dessertsCollectionView)
        setupConstraints()
    }
    private func setupConstraints() {
        let constraints = [
            dessertsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            dessertsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dessertsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dessertsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
