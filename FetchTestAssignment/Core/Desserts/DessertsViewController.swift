//
//  ViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

final class DessertsViewController: UIViewController {

    //MARK: Properties
    private var viewModel: DessertViewViewModelImpl
    private let dessertsView: DessertsView
    var collectionViewManager: CollectionViewManagerImpl
   
    //MARK: Init
    init(viewModel: DessertViewViewModelImpl, dessertsView: DessertsView, collectionViewManager: CollectionViewManagerImpl) {
        self.viewModel = viewModel
        self.dessertsView = dessertsView
        self.collectionViewManager = collectionViewManager
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
        getAllDesserts()
        goToDessertDetail()
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = .white
        title = "Desserts \u{1F9C1}"
    }
    
    private func injectCollectionViewManager() {
        collectionViewManager.inject(collectionView: dessertsView.dessertsCollectionView)
    }
    
    private func getAllDesserts() {
        viewModel.getDessert {
            DispatchQueue.main.async { [weak self] in
                self?.collectionViewManager.setViewModel(with: self!.viewModel)
                self?.injectCollectionViewManager()
            }
        }
    }
    
    private func goToDessertDetail() {
        collectionViewManager.navigateToDessertDetail = { [weak self] id in
            let vc = DessertDetailViewController(viewModel: DessertDetailViewViewModel(id: id), dessertDetailView: DessertDetailView(), tableViewManager: IngredientTableViewManager(), collectionViewManager: TypesCollectionViewManager())
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
