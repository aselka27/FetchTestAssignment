//
//  DessertsViewViewModel.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


typealias emptyCompletion = (()->())

protocol DessertViewViewModelImpl: AnyObject {
    func getDessert(completion: @escaping emptyCompletion)
    var allDesserts: [Meals]? { get }
}


class DessertViewViewModel: DessertViewViewModelImpl {
   
    var allDesserts: [Meals]? {
        didSet {
            allDesserts?.sort { $0 < $1 }
        }
    }
    let networkService = NetworkService.shared
    
    func getDessert(completion: @escaping emptyCompletion) {
        networkService.performFetch(urlRequest: MealsRouter.getDesserts(category: .Dessert).createURLRequest(), decodedModel: MealsResponse.self) { [weak self] result in
            switch result {
            case .success(let decodeModel):
                self?.allDesserts = decodeModel.meals
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
