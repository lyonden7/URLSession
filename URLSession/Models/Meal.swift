//
//  Meal.swift
//  URLSession
//
//  Created by Денис Васильев on 08.01.2023.
//

struct Meal: Decodable {
    let mealID: String
    let mealName: String
    let mealImageURL: String

    enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case mealImageURL = "strMealThumb"
    }
}

struct Meals: Decodable {
    let meals: [Meal]
}
