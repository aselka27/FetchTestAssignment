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
  
    //MARK: Init
    init(viewModel: DessertDetailViewViewModelImpl, dessertDetailView: DessertDetailView, tableViewManager: IngredientTableViewManagerImpl) {
        self.viewModel = viewModel
        self.dessertDetailView = dessertDetailView
        self.tableViewManager = tableViewManager
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
        injectTableView()
    }
    
    //MARK: ConfigureUI
    private func configureUI() {
        setDelegates()
        getDessertDetail()
    }
    
    private func setDelegates() {
        dessertDetailView.segmentCollectionView.delegate = self
        dessertDetailView.segmentCollectionView.dataSource = self
    }
    
    private func injectTableView() {
        tableViewManager.inject(tableView: dessertDetailView.ingredientsTableView)
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

   //MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension DessertDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Types.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as? SegmentCollectionViewCell else { return UICollectionViewCell() }
        let types = Types.allCases
        cell.configure(segmentType: types[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = dessertDetailView.segmentCollectionView.frame.size
        return CGSize(width: size.width/2-4, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dessertDetailView.directionsLabel.isHidden = indexPath.item == 0 ? true : false
        self.dessertDetailView.ingredientsTableView.isHidden = indexPath.item == 0 ? false : true
    }
}


