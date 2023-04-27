//
//  IngredientsTableViewManager.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 27.04.2023.
//

import UIKit

protocol IngredientTableViewManagerImpl: AnyObject {
    func inject(tableView: UITableView)
    func setViewModel(with viewModel: DessertDetailViewViewModelImpl)
}

final class IngredientTableViewManager: NSObject, IngredientTableViewManagerImpl {
    
    //MARK: Properties
    var tableView: UITableView?
    var viewModel: DessertDetailViewViewModelImpl? {
        didSet {
            updateView()
        }
    }
    
    //MARK: Init
    init(tableView: UITableView? = nil) {
        self.tableView = tableView
    }
    
    func inject(tableView: UITableView) {
        self.tableView = tableView
        configureTableView()
    }
    
    func setViewModel(with viewModel: DessertDetailViewViewModelImpl) {
        self.viewModel = viewModel
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func configureTableView() {
        guard let tableView = tableView else { return }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: IngredientTableViewCell.identifier)
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
    }
    
}

//MARK: UITableViewDataSource & UITableViewDelegate
extension IngredientTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientTableViewCell.identifier, for: indexPath) as? IngredientTableViewCell else { return UITableViewCell() }
        let ingredient = (viewModel?.ingredients[indexPath.row])!
        cell.configure(with: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? IngredientTableViewCell else {
            return
        }
        cell.isChecked.toggle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
