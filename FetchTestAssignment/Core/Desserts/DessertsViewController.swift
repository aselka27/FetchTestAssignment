//
//  ViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

class DessertsViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: DessertViewViewModelImpl
    private let dessertsView = DessertsView()
   
    //MARK: Init
    init(viewModel: DessertViewViewModelImpl) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = dessertsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getDessert {
            DispatchQueue.main.async { [weak self] in
                self?.dessertsView.dessertsCollectionView.reloadData()
            }
        }
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = .white
        title = "Desserts \u{1F9C1}"
        setDelegates()
    }
    
    private func setDelegates() {
        dessertsView.dessertsCollectionView.delegate = self
        dessertsView.dessertsCollectionView.dataSource = self
    }
}

     //MARK: CollectionViewDelegate & CollectionViewDatasource
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dessert = viewModel.allDesserts?[indexPath.item], let dessertId = dessert.idMeal else { return }
        let vc = DessertDetailViewController(viewModel: DessertDetailViewViewModel(id: dessertId))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertsView.dessertsCollectionView.frame.size
        return CGSize(width: (size.width/2)-16, height: 214)
    }
}
