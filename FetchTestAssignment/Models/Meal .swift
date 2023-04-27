//
//  Meals .swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


struct MealsResponse: Codable {
    let meals: [Meal]?
}

struct Meal: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}

extension Meal: Comparable {
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        guard let name1 = lhs.strMeal, let name2 = rhs.strMeal else {
            return false
        }
        return name1 < name2
    }
}
