//
//  DessertDetailViewViewModel.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


protocol DessertDetailViewViewModelImpl: AnyObject {
    func fetch(completion: @escaping emptyCompletion)
    var dessertDetail: MealDetail? { get }
}

class DessertDetailViewViewModel: DessertDetailViewViewModelImpl {
    
    private let networkService = NetworkService.shared
    var dessertDetail: MealDetail?
    var ingredients: [(String, String)] = []
    var id: String
    
    init(id: String) {
        self.id = id
    }
   
    func fetch(completion: @escaping emptyCompletion) {
        networkService.performFetch(urlRequest: MealsRouter.getMealDetails(mealID: id).createURLRequest(), decodedModel: MealDetailResponse.self) { [weak self] result in
            switch result {
            case .success(let decodedModel):
                self?.dessertDetail = decodedModel.meals?.first
                guard let ingredient =  decodedModel.meals?.first?.ingredients else {
                    return
                }
                self?.ingredients = self?.filterEmptyIngredients(ingredient) as! [(String, String)]
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func filterEmptyIngredients(_ ingredients:  [(ingr: String?, msr: String?)]) -> [(String?,  String?)] {
        ingredients.filter { ingr, msr in
            return !(ingr?.isEmpty ?? true) && !(msr?.isEmpty ?? true)
        }
    }
}
