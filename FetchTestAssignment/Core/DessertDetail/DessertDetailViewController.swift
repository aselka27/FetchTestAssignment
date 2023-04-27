//
//  DessertDetailViewController.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import UIKit

final class DessertDetailViewController: UIViewController {
    
    //MARK: Properties
    private let dessertDetailView: DessertDetailView
    private let viewModel: DessertDetailViewViewModelImpl
    private let tableViewManager: IngredientTableViewManagerImpl
    private let collectionViewManager: TypesCollectionViewManagerImpl
  
    //MARK: Init
    init(viewModel: DessertDetailViewViewModelImpl, dessertDetailView: DessertDetailView, tableViewManager: IngredientTableViewManagerImpl, collectionViewManager: TypesCollectionViewManagerImpl) {
        self.viewModel = viewModel
        self.dessertDetailView = dessertDetailView
        self.tableViewManager = tableViewManager
        self.collectionViewManager = collectionViewManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = dessertDetailView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        injectManagers()
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        getDessertDetail()
        injectManagers()
    }
    

    private func injectManagers() {
        tableViewManager.inject(tableView: dessertDetailView.ingredientsTableView)
        collectionViewManager.inject(collectionView: dessertDetailView.segmentCollectionView)
        
        collectionViewManager.passIndexPath = { [weak self] selectedIndex in
            self?.dessertDetailView.directionsLabel.isHidden = selectedIndex == 0 ? true : false
            self?.dessertDetailView.ingredientsTableView.isHidden = selectedIndex == 0 ? false : true
        }
    }
    
    private func getDessertDetail() {
        viewModel.fetch { [weak self] in
            DispatchQueue.main.async {
                guard let dessertDetail = self?.viewModel.dessertDetail else { return }
                self?.dessertDetailView.configure(with: dessertDetail)
                self?.tableViewManager.setViewModel(with: self!.viewModel)
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.dessertDetailView.segmentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            }
        }
    }
}


