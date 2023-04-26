//
//  Meals .swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


struct MealsResponse: Codable {
    let meals: [Meals]?
}

struct Meals: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}

extension Meals: Comparable {
    static func < (lhs: Meals, rhs: Meals) -> Bool {
        guard let name1 = lhs.strMeal, let name2 = rhs.strMeal else {
            return false
        }
        return name1 < name2
    }
}
