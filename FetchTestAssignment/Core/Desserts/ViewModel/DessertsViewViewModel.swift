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
    var allDesserts: [Meal]? { get }
}

final class DessertViewViewModel: DessertViewViewModelImpl {
   
     var networkService: any NetworkServiceProtocol = NetworkService.shared
    var allDesserts: [Meal]? {
        didSet {
            allDesserts?.sort { $0 < $1 }
        }
    }
    
    func getDessert(completion: @escaping emptyCompletion) {
//        networkService.performFetch(urlRequest: MealsRouter.getDesserts(category: .Dessert).createURLRequest(), decodedModel: MealsResponse.self) { [weak self] result in
//            switch result {
//            case .success(let decodeModel):
//                self?.allDesserts = decodeModel.meals
//                completion()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        Task { @MainActor in
            do {
                let mealsResponse: MealsResponse = try await networkService.performFetch(urlRequest: MealsRouter.getDesserts(category: .Dessert).createURLRequest())
                allDesserts = mealsResponse.meals
                completion()
            } catch {
                print(error.localizedDescription)
                completion()
            }
        }
    }
}
