//
//  DessertsCollectionViewManager.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 27.04.2023.
//

import UIKit

protocol DessertsCollectionViewManagerImpl: AnyObject {
    func setViewModel(with viewModel: DessertViewViewModelImpl)
    func inject(collectionView: UICollectionView)
    var navigateToDessertDetail: ((String)->())? { get set }
}

final class DessertsCollectionViewManager: NSObject, DessertsCollectionViewManagerImpl {
    
    //MARK: Properties
    var collectionView: UICollectionView?
    var viewModel: DessertViewViewModelImpl? {
        didSet {
            updateView()
        }
    }
    var navigateToDessertDetail: ((String) -> ())?
    
    //MARK: Init
    init(collectionView: UICollectionView? = nil) {
        self.collectionView = collectionView
    }
    
    func setViewModel(with viewModel: DessertViewViewModelImpl) {
        self.viewModel = viewModel
    }
    
    func inject(collectionView: UICollectionView) {
        self.collectionView = collectionView
        configureCollectionView()
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func configureCollectionView() {
        guard let collectionView else { return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 7, bottom: 60, right: 7)
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DessertCollectionViewCell.self, forCellWithReuseIdentifier:    DessertCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}



   //MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension DessertsCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.allDesserts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier, for: indexPath) as? DessertCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let dessert = viewModel?.allDesserts?[indexPath.item] {
            cell.configure(with: dessert)
        }
        return cell
    }
}

extension DessertsCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: (size.width/2)-16, height: 214)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dessert = viewModel?.allDesserts?[indexPath.item], let dessertId = dessert.idMeal else { return }
        navigateToDessertDetail?(dessertId)
    }
}
