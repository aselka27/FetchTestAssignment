//
//  MealsRouter.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


enum MealsRouter: BaseRouter {
    
case getDesserts(category: MealCategory)
case getMealDetails(mealID: String)
    
    var path: String {
        switch self {
        case .getDesserts:
            return "/api/json/v1/1/filter.php"
        case .getMealDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getDesserts:
            return .GET
        case .getMealDetails:
            return .GET
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getDesserts(let category):
            return [.init(name: "c", value: category.rawValue)]
        case .getMealDetails(let id):
            return [.init(name: "i", value: id)]
        }
    }
    
    var httpBody: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        default:
            return nil
        }
    }
}
